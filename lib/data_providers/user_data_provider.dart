import 'dart:io';

import 'package:bulkers/models/address.dart';
import 'package:bulkers/models/app_user.dart';
import 'package:bulkers/models/company.dart';
import 'package:bulkers/models/worker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';

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
    // Adding AppUser to Firestore
    CollectionReference appUserCollection = firestore.collection('AppUsers');
    appUserCollection.doc(company.companyId).update({
      'company': company.toMap(),
      'isBasicInformation': true
    }).catchError((error) {
      print("Error adding user to Firestore: $error");
    });

    CollectionReference companiesCollection = firestore.collection('Companies');
    company.isBasicProfileCompleted = true;
    companiesCollection
        .doc(company.companyId)
        .set(
          company.toMap(),
        )
        .catchError((error) {
      print("Error adding user to Firestore: $error");
    });
  }

  static void updateWorkerBasicInformation(Worker worker) {
    // Adding AppUser to Firestore
    CollectionReference appUserCollection = firestore.collection('AppUsers');
    appUserCollection.doc(worker.workerId).update({
      'worker': worker.toMap(),
      'isBasicInformation': true
    }).catchError((error) {
      print("Error adding user to Firestore: $error");
    });

    // Adding Worker to Firestore
    CollectionReference workersCollection = firestore.collection('Workers');
    workersCollection
        .doc(worker.workerId)
        .set(
          worker.toMap(),
        )
        .catchError((error) {
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

  static Future<void> updateUserBasicInfo(
      Map<String, dynamic> info, String uid) async {
    CollectionReference appUserCollection = firestore.collection('AppUsers');
    await appUserCollection.doc(uid).update(info).catchError((error) {
      print("Error adding user to Firestore: $error");
    });
  }

  static Future<void> updateCompanyInfo(
      Map<String, dynamic> info, String uid) async {
    CollectionReference appUserCollection = firestore.collection('AppUsers');
     CollectionReference companyCollection = firestore.collection('Companies');
    await appUserCollection
        .doc(uid)
        .update({"company": info}).catchError((error) {
      print("Error adding user to Firestore: $error");
    });
      await companyCollection
        .doc(uid)
        .update(info).catchError((error) {
      print("Error adding user to Firestore: $error");
    });
  }

    static Future<void> updateUserProfilePic(
      Map<String, dynamic> info, String uid) async {
    CollectionReference appUserCollection = firestore.collection('AppUsers');
   
    await appUserCollection
        .doc(uid)
        .update(info).catchError((error) {
      print("Error adding user to Firestore: $error");
    });
   
  }

  static Future<Map<String, dynamic>> loginUser(
      String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
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

  static Future<AppUser?> getAppUser(String uid) async {
    CollectionReference appUserCollection = firestore.collection('AppUsers');
    DocumentSnapshot documentSnapshot = await appUserCollection.doc(uid).get();

    if (documentSnapshot.exists) {
      Map<String, dynamic> data =
          documentSnapshot.data() as Map<String, dynamic>;
      return AppUser.fromMap(data);
    } else {
      return null; // or handle this scenario as per your requirements
    }
  }

  static Future<Map<String, dynamic>> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return {
        'success': true,
        'message': 'Password reset email sent successfully',
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

  static Future<String?> uploadImage({File? flow, String? path}) async {
    final firebaseStorage = FirebaseStorage.instance;
    // final imagePicker = ImagePicker();
    // PickedFile? image;
    String? imageUrl;
    //Check Permissions
    // await Permission.photos.request();

    // var permissionStatus = await Permission.photos.status;
    // if (kDebugMode) {
    //   print(permissionStatus);
    // }

    if (flow != null) {
      //  File(image.path);
      //Upload to Firebase
      var snapshot = firebaseStorage.ref().child(path!).putFile(flow).snapshot;
      await Future.delayed(Duration(seconds: 3));
      String downloadUrl = await snapshot.ref.getDownloadURL();
      // setState(() {
      imageUrl = downloadUrl;
      if (kDebugMode) {
        print(imageUrl);
      }
      return imageUrl;
      // });
    } else {
      if (kDebugMode) {
        print('No Image Path Received');
      }
      return '';
    }
  }
}
