import 'package:blukers/models/app_user/components/preference.dart';
import 'package:blukers/models/job_post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/jobs_page.dart';
import 'data_constants.dart';

final db = FirebaseFirestore.instance;

class JobsListsDataProvider {
  static Future<JobsPage> getAllJobsAtPage(JobsPage jobsPage) async {
    CollectionReference jobPosts =
        FirebaseFirestore.instance.collection(jobPostsCollections);

    // Number of job posts to fetch per page
    const int pageSize = 10;

    // Start the query based on lastDocument if present
    Query query =
        jobPosts.orderBy('dateCreated', descending: true).limit(pageSize);

    if (jobsPage.lastDocument != null) {
      query = query.startAfterDocument(jobsPage.lastDocument!);
    }

    // Execute the query
    QuerySnapshot querySnapshot = await query.get();

    // List to store job posts
    List<JobPost> jobPostList = [];

    // Process each document
    for (DocumentSnapshot document in querySnapshot.docs) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      JobPost? jobPost = JobPost.fromMap(data);
      if (jobPost != null) {
        jobPostList.add(jobPost);
      }
    }

    // Update the jobs page
    jobsPage.jobs.addAll(jobPostList);
    jobsPage.displayAllJobsPage++;

    if (jobPostList.isNotEmpty) {
      jobsPage.lastDocument = querySnapshot.docs.last;
    }

    return jobsPage;
  }

  static getJobsByPreferences(Preference preference) {}
}
