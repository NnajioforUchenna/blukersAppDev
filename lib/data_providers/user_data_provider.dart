import 'package:blukers/models/app_user/components/registration_status.dart';
import 'package:blukers/models/authResult.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../models/app_user/app_user.dart';
import '../models/company.dart';
import '../models/job_application_tracker.dart';
import '../models/reference_form.dart';
import '../models/work_experience.dart';
import '../models/worker.dart';
import 'data_constants.dart';

final firestore = FirebaseFirestore.instance;

class UserDataProvider {
  static String extractFirebaseError(String errorMessage) {
    String originalString = errorMessage;
    print("Error Message: $errorMessage");
    // This regex pattern captures the text between "Firebase: " and the error code in parentheses.
    RegExp pattern = RegExp(r'Firebase: (.*?)(?=\s\()');
    Match? match = pattern.firstMatch(errorMessage);

    if (match != null && match.groupCount >= 1) {
      return match.group(1)!; // Returns the captured Firebase error message
    } else {
      print("Error second Message: $originalString");
      return originalString;
    }
  }

  static Future<AuthResult> registerUser(String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      AuthResult authResult = AuthResult.isSuccess(userCredential);
      return authResult;
    } on FirebaseAuthException catch (e) {
      String errorMessage = extractFirebaseError(e.message!);
      AuthResult authResult = AuthResult.failure(errorMessage);
      return authResult;
    } catch (e) {
      AuthResult authResult = AuthResult.failure(e.toString());
      return authResult;
    }
  }

  static void registerUserToDatabase(AppUser appUser) {
    // Reference to the Firestore collection
    CollectionReference appUserCollection =
        firestore.collection(appUserCollections);
    appUserCollection.doc(appUser.uid).set(appUser.toMap()).catchError((error) {
      print("Error adding user to Firestore: $error");
    });
  }

  static void updateBasicInformation(Company company) {
    // Adding AppUser to Firestore
    CollectionReference appUserCollection =
        firestore.collection(appUserCollections);
    appUserCollection.doc(company.companyId).update({
      'company': company.toMap(),
      'isBasicInformation': true
    }).catchError((error) {
      print("Error adding user to Firestore: $error");
    });

    CollectionReference companiesCollection =
        firestore.collection(companyCollections);
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
    CollectionReference appUserCollection =
        firestore.collection(appUserCollections);
    appUserCollection.doc(worker.workerId).update({
      'worker': worker.toMap(),
      'isBasicInformation': true
    }).catchError((error) {
      print("Error adding user to Firestore: $error");
    });

    // Adding Worker to Firestore
    CollectionReference workersCollection =
        firestore.collection(workersCollections);
    workersCollection
        .doc(worker.workerId)
        .set(
          worker.toMap(),
        )
        .catchError((error) {
      print("Error adding user to Firestore: $error");
    });
  }

  static void updateContactInformation(String completePhoneNumber, String uid) {
    CollectionReference appUserCollection =
        firestore.collection(appUserCollections);
    appUserCollection.doc(uid).update({
      'phoneNumber': completePhoneNumber,
      // 'address': address.toMap(),
      'isContactInformation': true
    }).catchError((error) {
      print("Error adding user to Firestore: $error");
    });
  }

  static Future<void> updateUserBasicInfo(
      Map<String, dynamic> info, String uid) async {
    CollectionReference appUserCollection =
        firestore.collection(appUserCollections);
    await appUserCollection.doc(uid).update(info).catchError((error) {
      print("Error adding user to Firestore: $error");
    });
  }

  static Future<void> updateCompanyInfo(
      Map<String, dynamic> info, String uid) async {
    CollectionReference appUserCollection =
        firestore.collection(appUserCollections);
    CollectionReference companyCollection =
        firestore.collection(companyCollections);
    await appUserCollection
        .doc(uid)
        .update({"company": info}).catchError((error) {
      print("Error adding user to Firestore: $error");
    });
    await companyCollection.doc(uid).update(info).catchError((error) {
      print("Error adding user to Firestore: $error");
    });
  }

  static Future<void> updateWorkerInfo(
      Map<String, dynamic> info, String uid) async {
    CollectionReference appUserCollection =
        firestore.collection(appUserCollections);
    CollectionReference companyCollection =
        firestore.collection(workersCollections);
    await appUserCollection
        .doc(uid)
        .update({"worker": info}).catchError((error) {
      print("Error adding user to Firestore: $error");
    });
    await companyCollection.doc(uid).set(info).catchError((error) {
      print("Error adding user to Firestore: $error");
    });
  }

  static Future<void> updateUserProfilePic(
      Map<String, dynamic> info, String uid) async {
    CollectionReference appUserCollection =
        firestore.collection(appUserCollections);

    await appUserCollection.doc(uid).update(info).catchError((error) {
      print("Error adding user to Firestore: $error");
    });
  }

  static Future<AuthResult> loginUser(String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      AuthResult authResult = AuthResult.isSuccess(userCredential);
      return authResult;
    } on FirebaseAuthException catch (e) {
      String errorMessage = extractFirebaseError(e.message!);
      return AuthResult.failure(errorMessage);
    } catch (e) {
      return AuthResult.failure(e.toString());
    }
  }

  static Future<AppUser?> getAppUser(String? uid) async {
    CollectionReference appUserCollection =
        firestore.collection(appUserCollections);
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

  static void updateTimelineStep(String uid, int step) {
    CollectionReference appUserCollection =
        firestore.collection(appUserCollections);
    appUserCollection.doc(uid).update({
      'workerTimelineStep': step,
    }).catchError((error) {
      print("Error adding user to Firestore: $error");
    });
  }

  static void updateworkertimestep(String uid, int step) {
    CollectionReference appUserCollection =
        firestore.collection(appUserCollections);
    appUserCollection.doc(uid).update({
      'workerTimelineStep': step,
    }).catchError((error) {
      print("Error updating timeline step in Firestore: $error");
    });
  }

  static void updateWorkerAppliedJobPostIds(List<String> list, String uid) {
    CollectionReference appUserCollection =
        firestore.collection(appUserCollections);
    appUserCollection.doc(uid).update({
      'workerTimelineStep': 4,
      'worker.appliedJobPostIds': list,
    }).catchError((error) {
      print("Error adding user to Firestore: $error");
    });
  }

  static void updateWorkerSavedJobPostIds(List<String> list, String uid) {
    CollectionReference appUserCollection =
        firestore.collection(appUserCollections);
    appUserCollection.doc(uid).update({
      'worker.savedJobPostIds': list,
    }).catchError((error) {
      print("Error adding user to Firestore: $error");
    });
  }

  static void updatecompanyTimelineStep(String uid, int step) {
    CollectionReference appUserCollection =
        firestore.collection(appUserCollections);
    appUserCollection.doc(uid).update({
      'companyTimelineStep': step,
    }).catchError((error) {
      print("Error updating timeline step in Firestore: $error");
    });
  }

  static void createjobTimelineStep(String uid, int step) {
    CollectionReference appUserCollection =
        firestore.collection(appUserCollections);
    appUserCollection.doc(uid).update({
      'companyTimelineStep': step,
    }).catchError((error) {
      print("Error updating timeline step in Firestore: $error");
    });
  }

  static Future<void> addInterestingWorker(String uid, String workerId) async {
    final CollectionReference usersCollection =
        FirebaseFirestore.instance.collection(appUserCollections);

    // Reference to the user's document
    final DocumentReference userDoc = usersCollection.doc(uid);

    // Update the interestingWorkersIds field by adding workerId
    await userDoc.update({
      'company.interestingWorkersIds': FieldValue.arrayUnion([workerId])
    });
  }

  static Future<String?> uploadImage({Uint8List? image, String? path}) async {
    // final firebaseStorage = FirebaseStorage.instance;
    // final imagePicker = ImagePicker();
    // PickedFile? image;
    // String? imageUrl;
    //Check Permissions
    // await Permission.photos.request();

    // var permissionStatus = await Permission.photos.status;
    // if (kDebugMode) {
    //   print(permissionStatus);
    // }
    final storageRef = FirebaseStorage.instance.ref();
    Reference? imagesRef = storageRef.child(path!);
    String imageUrl = '';

    try {
      print(image?.lengthInBytes.toString());
      final uploadTask = await imagesRef.putData(
        image!,
      );
      imageUrl = await uploadTask.ref.getDownloadURL();
      // Set the logoUrl in the database
      // await updateOrAddUserPhoto(uid, imageUrl);
      return imageUrl;
    } catch (e) {
      print(e);
      return 'error';
    }
    // if (flow != null) {
    //   //  File(image.path);
    //   //Upload to Firebase
    //   var snapshot = firebaseStorage.ref().child(path!).putFile(flow).snapshot;
    //   await Future.delayed(Duration(seconds: 5));
    //   String downloadUrl = await snapshot.ref.getDownloadURL();
    //   // setState(() {
    //   imageUrl = downloadUrl;
    //   if (kDebugMode) {
    //     print(imageUrl);
    //   }
    //   return imageUrl;
    //   // });
    // } else {
    //   if (kDebugMode) {
    //     print('No Image Path Received');
    //   }
    //   return '';
    // }
  }

  static Future<void> _deleteUserMessages(String roomId) async {
    // Reference to the main document
    DocumentReference mainDocRef =
        FirebaseFirestore.instance.collection("ChatMessages").doc(roomId);

// Reference to the sub-collection
    CollectionReference subCollectionRef = mainDocRef.collection("messages");

// Delete all documents within the sub-collection
    QuerySnapshot messagesSnapshot = await subCollectionRef.get();
    for (QueryDocumentSnapshot docSnapshot in messagesSnapshot.docs) {
      await docSnapshot.reference.delete();
    }

// Delete the main document
    await mainDocRef.delete();
  }

  static Future<void> _deleteUserChats(String uid) async {
    var snapshot = await firestore
        .collection('ChatRooms')
        .where("members", arrayContains: uid)
        .get();
    for (int i = 0; i < snapshot.docs.length; i++) {
      Map<String, dynamic> res = snapshot.docs[i].data();
      //print(snapshot.docs[i].data());

      await firestore.collection("ChatRooms").doc(res["id"]).delete();
      await _deleteUserMessages(res["id"]);
    }
  }

  static Future<void> _removeFieldFromDocuments(String collection, String field,
      String companyId, String workerId) async {
    try {
      DocumentReference companyRef =
          firestore.collection(collection).doc(companyId);
      DocumentSnapshot companySnapshot = await companyRef.get();

      if (companySnapshot.exists && companySnapshot.data() != null) {
        List<dynamic> interestingWorkersIds = companySnapshot.get(field);

        if (interestingWorkersIds.contains(workerId)) {
          interestingWorkersIds.remove(workerId);
          await companyRef.update({field: interestingWorkersIds});
          print('Worker ID removed from interestingWorkersIds if existed.');
        }
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  static Future<void> _removeField(
      {required String documentIdName,
      required String collection,
      required String field,
      required String workerId}) async {
    var snapshot = await firestore
        .collection(collection)
        .where(field, arrayContains: workerId)
        .get();
    for (int i = 0; i < snapshot.docs.length; i++) {
      Map<String, dynamic> res = snapshot.docs[i].data();
      //print(snapshot.docs[i].data());

      await _removeFieldFromDocuments(
          collection, field, res[documentIdName], workerId);
    }
  }

  static Future<void> _deleteWorker(String uid) async {
    await firestore.collection(workersCollections).doc(uid).delete();
    await firestore.collection(appUserCollections).doc(uid).delete();
  }

  static Future<void> _deleteCompany(String uid) async {
    await firestore.collection(companyCollections).doc(uid).delete();
    await firestore.collection(appUserCollections).doc(uid).delete();
  }

  static Future<void> _removeWorkerFromAllCollections(String workerId) async {
    await _removeField(
        documentIdName: "companyId",
        collection: companyCollections,
        field: "interestingWorkersIds",
        workerId: workerId);
    print("intrested worker deleted");
    await _removeField(
        documentIdName: "jobPostId",
        collection: jobPostsCollections,
        field: "applicantUserIds",
        workerId: workerId);
    print("applied job posts deleted deleted");
    await _removeField(
        documentIdName: "jobPostId",
        collection: jobPostsCollections,
        field: "declineUserIds",
        workerId: workerId);
    print("decline job posts deleted deleted");
    await _removeField(
        documentIdName: "jobPostId",
        collection: jobPostsCollections,
        field: "interviewedUserIds",
        workerId: workerId);
    print("interview job posts deleted deleted");
    await _removeField(
        documentIdName: "jobPostId",
        collection: jobPostsCollections,
        field: "hiredUserIds",
        workerId: workerId);
    print("hired job posts deleted deleted");
    await _deleteWorker(workerId);
  }

  static Future<void> _deleteJobPosts(String uid) async {
    var snapshot = await firestore
        .collection(jobPostsCollections)
        .where("companyId", isEqualTo: uid)
        .get();
    for (int i = 0; i < snapshot.docs.length; i++) {
      Map<String, dynamic> res = snapshot.docs[i].data();
      //print(snapshot.docs[i].data());

      await firestore
          .collection(jobPostsCollections)
          .doc(res["jobPostId"])
          .delete();
      await _removeField(
          documentIdName: "workerId",
          collection: workersCollections,
          field: "savedJobPostIds",
          workerId: res["jobPostId"]);
    }
  }

  static Future<void> _removeCompanyFromAllCollections(String companyId) async {
    await _deleteJobPosts(companyId);
    print("jobPosts deleted");
    await _deleteCompany(companyId);
  }

  static Future<void> deleteUser(String uid, bool isCompany) async {
    await _deleteUserChats(uid);
    print("chats deleted");
    if (isCompany) {
      await _removeCompanyFromAllCollections(uid);
    } else {
      await _removeWorkerFromAllCollections(uid);
    }
  }

  static void updateNumOfJobsAppliedToday(
      JobApplicationTracker? jobApplicationTracker, String uid) {
    CollectionReference appUserCollection =
        firestore.collection(appUserCollections);
    appUserCollection.doc(uid).update({
      'jobApplicationTracker': jobApplicationTracker?.toMap(),
    }).catchError((error) {
      print("Error adding user to Firestore: $error");
    });
  }

  static void updateUserInformation({
    required String firstName,
    required String middleName,
    required String lastName,
    required String description,
    required String uid,
  }) {
    CollectionReference appUserCollection =
        firestore.collection(appUserCollections);

    appUserCollection.doc(uid).update({
      'worker.firstName': firstName,
      'worker.middleName': middleName,
      'worker.lastName': lastName,
      'worker.workerBriefDescription': description,
    }).catchError((error) {
      print("Error adding user to Firestore: $error");
    });
  }

  // for company basic information
  static void updateCompanyBasicInformation({
    required String name,
    required String description,
    required List<String> email,
    required List<String> phoneNumber,
    required String uid,
  }) {
    CollectionReference appUserCollection =
        firestore.collection(appUserCollections);

    appUserCollection.doc(uid).update({
      'company.name': name,
      'company.companyDescription': description,
      'company.emails': email,
      'company.phoneNumbers': phoneNumber,
    }).catchError((error) {
      print("Error adding user to Firestore: $error");
    });
  }

  // for company information
  static void updateCompanyInformation({
    required int yearFounded,
    required int totalEmployees,
    required String uid,
  }) {
    CollectionReference appUserCollection =
        firestore.collection(appUserCollections);

    appUserCollection.doc(uid).update({
      'company.yearFounded': yearFounded,
      'company.totalEmployees': totalEmployees,
    }).catchError((error) {
      print("Error adding user to Firestore: $error");
    });
  }

  static void updateWorkerIndustriesAndJobs(AppUser? appUser) {
    CollectionReference appUserCollection =
        firestore.collection(appUserCollections);

    appUserCollection.doc(appUser!.uid).update({
      'worker.industryIds': appUser.workerResumeDetails!.industryIds,
      'worker.jobIds': appUser.workerResumeDetails!.jobIds,
    }).catchError((error) {
      print("Error adding user to Firestore: $error");
    });
  }

  static void updateResumeUrl(String uid, String url) {
    CollectionReference appUserCollection =
        firestore.collection(appUserCollections);

    appUserCollection.doc(uid).update({
      'worker.pdfResumeUrl': url,
    }).catchError((error) {
      print("Error adding user to Firestore: $error");
    });
  }

  static updateWorkerReferences(List<ReferenceForm> list, String uid) {
    CollectionReference appUserCollection =
        firestore.collection(appUserCollections);
    appUserCollection.doc(uid).update({
      'worker.references': list.map((e) => e.toMap()).toList(),
    }).catchError((error) {
      print("Error adding user to Firestore: $error");
    });
  }

  static updateWorkerWorkExperiences(List<WorkExperience> list, String uid) {
    CollectionReference appUserCollection =
        firestore.collection(appUserCollections);
    appUserCollection.doc(uid).update({
      'worker.workExperiences': list.map((e) => e.toMap()).toList(),
    }).catchError((error) {
      print("Error adding user to Firestore: $error");
    });
  }

  static void updateJobsPreference(AppUser? appUser) {
    if (appUser == null || appUser.uid.isEmpty) {
      print("Error: appUser is null or UID is empty");
      return;
    }

    RegistrationStatus status = RegistrationStatus();
    status.isJobsPreference = true;
    // Assuming 'firestore' is a correctly initialized FirebaseFirestore instance
    // and 'appUserCollections' holds the correct name of the collection
    CollectionReference appUserCollection = firestore.collection(
        appUserCollections); // Use the actual name of your collection

    appUserCollection.doc(appUser.uid).set({
      'workerTimelineStep': 2,
      'jobsPreference': {
        'industryIds':
            appUser.registrationDetails?.jobsPreference?.industryIds ?? [],
        'jobIds': appUser.registrationDetails?.jobsPreference?.jobIds ?? {},
      }
    }, SetOptions(merge: true)).catchError((error) {
      print("Error adding user to Firestore: $error");
    });
  }

  static void updateNotificationStatus(String uid, String notificationStatus) {
    CollectionReference appUserCollection =
        firestore.collection(appUserCollections);

    appUserCollection.doc(uid).update({
      'notificationStatus': notificationStatus,
    }).catchError((error) {
      print("Error adding user to Firestore: $error");
    });
  }

  static saveTokenToDatabase(String token, String uid) {
    CollectionReference appUserCollection =
        firestore.collection(appUserCollections);

    appUserCollection.doc(uid).update({
      'tokens': FieldValue.arrayUnion([token]),
    }).catchError((error) {
      print("Error adding user to Firestore: $error");
    });
  }

  static Future<AuthResult> signInWithGoogle() async {
    // Implement the Google Sign-In functionality here

    // final googleAccount = await GoogleSignIn().signIn();

    GoogleSignInAccount? googleAccount;

    if (kIsWeb) {
      // googleAccount = await GoogleSignIn(
      //   scopes: ['email', 'profile'],
      // ).signInSilently();

      GoogleAuthProvider googleProvider = GoogleAuthProvider();
      googleProvider
          .addScope('https://www.googleapis.com/auth/contacts.readonly');

      final userCredential =
          await FirebaseAuth.instance.signInWithPopup(googleProvider);

      return AuthResult.isSuccess(userCredential);
    } else {
      googleAccount = await GoogleSignIn().signIn();
    }

    final googleAuth = await googleAccount?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    final userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    if (userCredential.user != null) {
      print('Successfully signed in with Google');
      return AuthResult.isSuccess(userCredential);
    } else {
      print('Failed to sign in with Google');
      return AuthResult.failure('Failed to sign in with Google');
    }
  }

  static Future<AuthResult> signInWithApple() async {
    // Implement the Apple Sign-In functionality here
    final appleProvider = AppleAuthProvider();
    final userCredential =
        await FirebaseAuth.instance.signInWithProvider(appleProvider);
    if (userCredential.user != null) {
      print('Successfully signed in with Apple');
      return AuthResult.isSuccess(userCredential);
    } else {
      print('Failed to sign in with Apple');
      return AuthResult.failure('Failed to sign in with Apple');
    }
  }

  static Future<AuthResult> signInWithFacebook() async {
    // Implement the Facebook Sign-In functionality here

    if (kIsWeb) {
      await FacebookAuth.i.webAndDesktopInitialize(
        appId: "326245573545115",
        cookie: true,
        xfbml: true,
        version: "v15.0",
      );
    }

    final LoginResult result = await FacebookAuth.instance.login();
    if (result.status == LoginStatus.success) {
      // Create a credential from the access token
      final OAuthCredential credential =
          FacebookAuthProvider.credential(result.accessToken!.token);
      // Once signed in, return the UserCredential
      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      if (userCredential.user != null) {
        print('Successfully signed in with Facebook');
        return AuthResult.isSuccess(userCredential);
      } else {
        print('Failed to sign in with Facebook');
        return AuthResult.failure('Failed to sign in with Facebook');
      }
    } else {
      return AuthResult.failure('Failed Trying to get Facebook Login Instance');
    }
  }

  static Future<bool> isUserRegistered(String uid) {
    CollectionReference appUserCollection =
        firestore.collection(appUserCollections);
    return appUserCollection.doc(uid).get().then((doc) {
      return doc.exists;
    });
  }

  static Future<void> saveOtherCompanyJobPosts(
      List<String> jobPostsIds, String companyId) async {
    // Get a reference to the 'companies' collection
    CollectionReference companies = firestore.collection('Companies');

    // Update the companyId in each JobPost document in the database
    for (String jobPostId in jobPostsIds) {
      DocumentReference jobPostDoc =
          firestore.collection('JobPosts').doc(jobPostId);
      await jobPostDoc.update({'companyId': companyId});
    }

    // Get a reference to the specific company document
    DocumentReference companyDoc = companies.doc(companyId);

    // Add the new job post IDs to the 'jobPostIds' field in the company document
    await companyDoc.update({'jobPostIds': FieldValue.arrayUnion(jobPostsIds)});
  }

  static void updateUser(AppUser appUser) {
    CollectionReference appUserCollection =
        firestore.collection(appUserCollections);
    appUserCollection.doc(appUser.uid).set(appUser.toMap()).catchError((error) {
      print("Error adding user to Firestore: $error");
    });
  }
}
