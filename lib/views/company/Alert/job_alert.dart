import 'package:blukers/views/company/Alert/job_noti.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class JobAlertList extends StatefulWidget {
  @override
  _JobAlertListState createState() => _JobAlertListState();
}

class _JobAlertListState extends State<JobAlertList> with WidgetsBindingObserver {
  List<String> jobAlerts = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool isLoading = true; // Track loading state
  late JobNotificationHandler jobNotificationHandler;

  @override
  void initState() {
    super.initState();
    jobNotificationHandler = JobNotificationHandler(); // Initialize job notification handler
    _loadAlertJobs();  // Load initial job alerts
    WidgetsBinding.instance.addObserver(this); // Add lifecycle observer
  }

  // Fetch the alerted jobs from Firestore for the current user
  Future<void> _loadAlertJobs() async {
    String uid = FirebaseAuth.instance.currentUser?.uid ?? 'guest';

    try {
      // Get the user's alerts document
      DocumentSnapshot userAlertsDoc =
          await _firestore.collection('alerts').doc(uid).get();

      if (userAlertsDoc.exists && userAlertsDoc.data() != null) {
        Map<String, dynamic> alertsData =
            userAlertsDoc.data() as Map<String, dynamic>;

        // Add all job IDs that have alerts set to true
        setState(() {
          jobAlerts = alertsData.keys
              .where((jobId) => alertsData[jobId] == true)
              .toList();
        });

        // Start or stop the listener based on the number of alerts
        if (jobAlerts.isEmpty) {
          jobNotificationHandler.stopListeningForNewJobs(); // Stop listening if no alerts
        } else {
          jobNotificationHandler.listenForNewJobs(); // Start listening if there are alerts
        }
      }
    } catch (e) {
      print('Error fetching job alerts: $e');
    } finally {
      setState(() {
        isLoading = false; 
      });
    }
  }

  // Lifecycle listener for when app is paused/resumed
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      jobNotificationHandler.stopListeningForNewJobs(); // Stop listening when app is paused
    } else if (state == AppLifecycleState.resumed) {
      // Ensure the listener is active if there are job alerts
      if (jobAlerts.isNotEmpty) {
        jobNotificationHandler.listenForNewJobs();
      }
    }
  }

  @override
  void dispose() {
    // Remove the lifecycle observer
    WidgetsBinding.instance.removeObserver(this);
    
    // Stop the listener only if jobAlerts is empty
    if (jobAlerts.isEmpty) {
      jobNotificationHandler.stopListeningForNewJobs();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: isLoading
          ? Center(child: CircularProgressIndicator()) 
          : jobAlerts.isEmpty
              ? Center(child: Text('No job alerts set'))
              : ListView.separated(
                  itemCount: jobAlerts.length,
                  separatorBuilder: (context, index) => Divider(),
                  itemBuilder: (context, index) {
                    final jobId = jobAlerts[index];
                    return ListTile(
                      leading: Icon(Icons.work_outline, size: 40),
                      title: Text(
                        ' $jobId',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text('You have an alert set for this job'),
                      trailing: IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          // Handle edit alert action
                        },
                      ),
                    );
                  },
                ),
    );
  }
}
