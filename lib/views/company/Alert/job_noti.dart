import 'dart:async';

import 'package:blukers/data_providers/push_notification.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class JobNotificationHandler {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  StreamSubscription<QuerySnapshot>? _jobSubscription;
  List<String> jobAlerts = [];

  // Load alerted job IDs
  // Listen for new jobs added to the 'jobs' collection
  void listenForNewJobs() {
  print('Entering listenForNewJobs()');
  
  if (_jobSubscription != null) {
    print('Already listening, returning');
    return; // Already listening
  }

  try {
    print('Setting up listener');
    _jobSubscription = _firestore.collection('Scrappedjobs').snapshots().listen(
      (snapshot) {
        print('Received snapshot, changes: ${snapshot.docChanges.length}');
        for (var change in snapshot.docChanges) {
          if (change.type == DocumentChangeType.added) {
            var docId = change.doc.id;
            var jobData = change.doc.data();
            print('New document added: $docId');

            if (jobData != null && jobData.containsKey('jobIds')) {
              List jobIds = List.from(jobData['jobIds']);
              print('JobIds in document: $jobIds');

              for (var jobId in jobIds) {
                print('Checking jobId: $jobId');
                if (jobAlerts.contains(jobId)) {
                  print("Job $jobId added to alerts list");
                  _handleNewJobAdded(jobId, jobData);
                }
              }
            } else {
              print('Document does not contain jobIds field');
            }
          }
        }
      },
      onError: (error) => print('Error in Firestore listener: $error'),
    );

    print('Started listening for new jobs');
  } catch (e) {
    print('Error setting up listener: $e');
  }
}
  // Handle new job addition and notify users subscribed to this jobId
  void _handleNewJobAdded(String jobId, Map<String, dynamic>? jobData) async {
    await DataNotificationProvider.sendPushNotification(
      title: 'New Job Posted',
      body:
          'A new job has been added: ${jobData?['title'] ?? 'Unknown Job Title'} For this job position: $jobId ',
      uid: FirebaseAuth.instance.currentUser!.uid,
    );

    // Store notification in Firestore for this user
    await _storeNotification(jobId, jobData?['title']);
  }

  // Store the notification in Firestore for tracking
  Future<void> _storeNotification(String jobId, String? jobTitle) async {
    String uid = FirebaseAuth.instance.currentUser?.uid ?? 'guest';

    await _firestore
        .collection('notifications')
        .doc(uid)
        .collection('user_notifications')
        .add({
      'jobId': jobId,
      'title': jobTitle ?? 'Unknown Job Title',
      'timestamp': FieldValue.serverTimestamp(),
    });

    print('Stored notification for job: $jobId');
  }

  // Stop listening for new jobs
  void stopListeningForNewJobs() {
    if (_jobSubscription != null) {
      _jobSubscription!.cancel();
      _jobSubscription = null;
      print('Stopped listening for new jobs');
    }
  }
}
