import 'dart:async';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../models/app_user.dart';
import '../models/job_post.dart';
import '../models/worker.dart';
import 'data_constants.dart';
import 'user_data_provider.dart';

final FirebaseFirestore db = FirebaseFirestore.instance;

class CompanyDataProvider {
  static void addInterestingWorker(AppUser? appUser, Worker worker) {
    CollectionReference companiesCollection =
        firestore.collection(companyCollections);
    if (appUser == null) return;
    companiesCollection.doc(appUser.uid).set(
      {
        'interestingWorkers': FieldValue.arrayUnion([worker.workerId]),
      },
      SetOptions(merge: true),
    ).catchError((error) {
      print("Error adding user to Firestore: $error");
    });
  }

  static final StreamController<List<Worker>> _streamController =
      StreamController<List<Worker>>.broadcast();

  static final StreamController<List<JobPost>> _jobPostStreamController =
      StreamController<List<JobPost>>.broadcast();

  static StreamController<List<JobPost>> fetchMyJobPosts(String companyId) {
    db.collection(companyCollections).doc(companyId).get().then((doc) {
      if (doc.exists) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        List<dynamic> jobPostIdList = data['jobPostIds'] ?? [];
        List<JobPost> returnJobPostList = [];
        int index = 0;

        Future.forEach(jobPostIdList, (jobPostId) async {
          DocumentSnapshot jobPostDoc =
              await db.collection(jobPostsCollections).doc(jobPostId).get();
          if (jobPostDoc.exists) {
            Map<String, dynamic> jobPostData =
                jobPostDoc.data() as Map<String, dynamic>;
            JobPost? jobPost = JobPost.fromMap(jobPostData);
            if (jobPost != null) {
              print(
                  'job post index: ${index} id as ${jobPostId} and company id as  ${jobPost.companyId}');
              returnJobPostList.add(jobPost);
              index++;
            }
          }
        }).then((_) {
          _jobPostStreamController.add(returnJobPostList);
        });
      } else {
        _jobPostStreamController.add([]);
      }
    });

    return _jobPostStreamController;
  }

  static StreamController<List<Worker>> fetchInterestingWorkers(
      String companyId) {
    StreamController<List<Worker>> streamController =
        StreamController<List<Worker>>();
    db.collection(companyCollections).doc(companyId).get().then((doc) {
      if (doc.exists) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        List<dynamic> workerList = data['interestingWorkers'] ?? [];
        List<Worker> returnWorkerList = [];
        Future.forEach(workerList, (workerId) async {
          DocumentSnapshot workerDoc =
              await db.collection(workersCollections).doc(workerId).get();
          if (workerDoc.exists) {
            Map<String, dynamic> workerData =
                workerDoc.data() as Map<String, dynamic>;
            Worker? worker = Worker.fromMap(workerData);
            if (worker != null) {
              returnWorkerList.add(worker); // Only add if not null
            }
          }
        }).then((_) {
          streamController.add(returnWorkerList);
        });
      } else {
        streamController.add([]);
      }
    });
    return streamController;
  }

  static void streamDispose() {
    _streamController.close();
    _jobPostStreamController.close();
  }

  static uploadImageToFirebaseStorage(
      String uid, Uint8List? image, String extention) async {
    final storageRef = FirebaseStorage.instance.ref();
    Reference? imagesRef =
        storageRef.child("ProfileImages/$uid/profileImage.$extention");
    String imageUrl = '';

    try {
      print(image?.lengthInBytes.toString());
      final uploadTask = await imagesRef.putData(
        image!,
        SettableMetadata(
          contentType: "image/$extention",
        ),
      );
      imageUrl = await uploadTask.ref.getDownloadURL();
      // Set the logoUrl in the database
      await updateOrAddUserPhoto(uid, imageUrl);
      return imageUrl;
    } catch (e) {
      print(e);
      return 'error';
    }
  }

  static updateOrAddUserPhoto(String uid, String photoUrl) async {
    await db.collection(appUserCollections).doc(uid).set({
      'photoUrl': photoUrl,
    }, SetOptions(merge: true));

    // For AppUsers collection with worker map
    await db.collection(appUserCollections).doc(uid).set({
      'company': {
        'logoUrl': photoUrl,
      },
    }, SetOptions(merge: true));

    // For workers collection
    await db.collection(companyCollections).doc(uid).set({
      'logoUrl': photoUrl,
    }, SetOptions(merge: true));
  }

  static Future<void> createCompanyProfile(
      String uid, Map<String, dynamic> createCompanyProfileData) async {
    await db
        .collection(companyCollections)
        .doc(uid)
        .set(createCompanyProfileData, SetOptions(merge: true));

    await db.collection(appUserCollections).doc(uid).set({
      'company': createCompanyProfileData,
    }, SetOptions(merge: true));
  }

  static void updateCompanyTimelineStep(String uid, int i) {
    db.collection(appUserCollections).doc(uid).set({
      'companyTimelineStep': i,
    }, SetOptions(merge: true));
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
}
