import 'dart:async';

import 'package:bulkers/data_providers/user_data_provider.dart';
import 'package:bulkers/models/app_user.dart';
import 'package:bulkers/models/worker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/job_post.dart';

final FirebaseFirestore db = FirebaseFirestore.instance;

class CompanyDataProvider {
  static void addInterestingWorker(AppUser? appUser, Worker worker) {
    CollectionReference companiesCollection = firestore.collection('Companies');
    if (appUser == null) return;
    companiesCollection.doc(appUser!.uid).set(
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
    db.collection('Companies').doc(companyId).get().then((doc) {
      if (doc.exists) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        List<dynamic> jobPostIdList = data['jobPostIds'] ?? [];
        List<JobPost> returnJobPostList = [];

        Future.forEach(jobPostIdList, (jobPostId) async {
          DocumentSnapshot jobPostDoc =
              await db.collection('JobPosts').doc(jobPostId).get();
          if (jobPostDoc.exists) {
            Map<String, dynamic> jobPostData =
                jobPostDoc.data() as Map<String, dynamic>;
            returnJobPostList.add(JobPost.fromMap(jobPostData));
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
    db.collection('Companies').doc(companyId).get().then((doc) {
      if (doc.exists) {
        Map<String, dynamic> data = doc.data()
            as Map<String, dynamic>; // Type casting to Map<String, dynamic>
        List<dynamic> workerList = data['interestingWorkers'] ?? [];
        List<Worker> returnWorkerList = [];
        Future.forEach(workerList, (workerId) async {
          DocumentSnapshot workerDoc =
              await db.collection('workers').doc(workerId).get();
          if (workerDoc.exists) {
            Map<String, dynamic> workerData = workerDoc.data()
                as Map<String, dynamic>; // Type casting to Map<String, dynamic>
            returnWorkerList.add(Worker.fromMap(workerData));
          }
        }).then((_) {
          _streamController.add(returnWorkerList);
        });
      } else {
        _streamController.add([]);
      }
    });
    return _streamController;
  }

  static void streamDispose() {
    _streamController.close();
    _jobPostStreamController.close();
  }
}
