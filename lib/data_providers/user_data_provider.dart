import 'package:bulkers/models/address.dart';
import 'package:bulkers/models/app_user.dart';
import 'package:bulkers/models/company.dart';
import 'package:bulkers/models/worker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final firestore = FirebaseFirestore.instance;

class UserDataProvider {
  static String extractFirebaseError(String errorMessage) {
    // This regex pattern captures the text between "Firebase: " and the error code in parentheses.
    RegExp pattern = RegExp(r'Firebase: (.*?)(?=\s\()');
    Match? match = pattern.firstMatch(errorMessage);

    if (match != null && match.groupCount >= 1) {
      return match.group(1)!; // Returns the captured Firebase error message
    }
    return "Unknown Error Please Check your Internet"; // Default error message if no match is found
  }

  static Future<Map<String, dynamic>> registerUser(
      String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return {
        'success': true,
        'userCredential': userCredential,
      };
    } on FirebaseAuthException catch (e) {
      String errorMessage = extractFirebaseError(e.message!);
      return {
        'success': false,
        'error': errorMessage,
      };
    } catch (e) {
      return {
        'success': false,
        'error': e.toString(),
      };
    }
  }

  static void registerUserToDatabase(AppUser appUser) {
    // Reference to the Firestore collection
    CollectionReference appUserCollection = firestore.collection('AppUsers');
    appUserCollection.doc(appUser.uid).set(appUser.toMap()).catchError((error) {
      print("Error adding user to Firestore: $error");
    });
  }

  static void updateBasicInformation(Company company) {
    // Reference to the Firestore collection
    CollectionReference appUserCollection = firestore.collection('AppUsers');
    appUserCollection.doc(company.companyId).update({
      'company': company.toMap(),
      'isBasicInformation': true
    }).catchError((error) {
      print("Error adding user to Firestore: $error");
    });
  }

  static void updateWorkerBasicInformation(Worker worker) {
    CollectionReference appUserCollection = firestore.collection('AppUsers');
    appUserCollection.doc(worker.workerId).update({
      'worker': worker.toMap(),
      'isBasicInformation': true
    }).catchError((error) {
      print("Error adding user to Firestore: $error");
    });
  }

  static void updateContactInformation(
      String completePhoneNumber, Address address, String uid) {
    CollectionReference appUserCollection = firestore.collection('AppUsers');
    appUserCollection.doc(uid).update({
      'completePhoneNumber': completePhoneNumber,
      'address': address.toMap(),
      'isContactInformation': true
    }).catchError((error) {
      print("Error adding user to Firestore: $error");
    });
  }
}
