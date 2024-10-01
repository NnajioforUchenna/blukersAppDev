import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class JobAlertManager {
  final BuildContext context;
  final String? jobId;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  JobAlertManager(this.context, this.jobId);

  Future<void> _showAlertSnackbar(bool isAlertOn) async {
    final snackBar = SnackBar(
      content: RichText(
        text: TextSpan(
          text: isAlertOn ? 'Your job alert was created. ' : 'Your job alert was removed. ',
          style: TextStyle(color: Colors.white),
          children: [
            TextSpan(
              text: 'Manage alert',
              style: const TextStyle(
                color: Colors.blue,
                decoration: TextDecoration.underline,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pushNamed(context, '/alertScreen');
                },
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<bool> loadAlertState() async {
    String uid = FirebaseAuth.instance.currentUser?.uid ?? 'guest';

    DocumentSnapshot userAlertsDoc = await _firestore.collection('alerts').doc(uid).get();

    return userAlertsDoc.exists
        ? (userAlertsDoc.data() != null &&
            (userAlertsDoc.data() as Map<String, dynamic>).containsKey('$jobId'))
            ? (userAlertsDoc.data() as Map<String, dynamic>)['$jobId'] ?? false
            : false
        : false;
  }

  Future<void> saveAlertState(bool value) async {
    String uid = FirebaseAuth.instance.currentUser?.uid ?? 'guest';

    await _firestore.collection('alerts').doc(uid).set({
      '$jobId': value,
    }, SetOptions(merge: true));

    _showAlertSnackbar(value);
    subscribeToJob();
  }

  Future<void> toggleAlert(bool value) async {
    if (value) {
      await saveAlertState(value);
    } else {
      await unsubscribeFromJob(value);
    }
  }


  void subscribeToJob() {
    print('Subscribed to job alerts for: $jobId');
    
  }

  Future<void> unsubscribeFromJob( bool value) async {
    String uid = FirebaseAuth.instance.currentUser?.uid ?? 'guest';

    // Remove the jobId from the alerts collection
    await _firestore.collection('alerts').doc(uid).update({
      '$jobId': FieldValue.delete(), // This will delete the specific jobId entry
    });

    print('Unsubscribed from job alerts for: $jobId');
      _showAlertSnackbar(value);
  }
}
