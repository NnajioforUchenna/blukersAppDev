import 'package:flutter/material.dart';

import '../data_providers/job_posts_data_provider.dart';
import '../models/job_post.dart';

class JobPostsProvider with ChangeNotifier {
  Map<String, JobPost> _jobPosts = {};

  Map<String, JobPost> get jobPosts => _jobPosts;

  List<JobPost> selectedJobPosts = [];

  void getJobPostsByJobID(String jobId) {
    // Get all jobPosts for the job with the given jobId.
    JobPostsDataProvider.getJobPostsByJobID(jobId).then((jobPosts) {
      selectedJobPosts = jobPosts.map((jobPost) {
        return JobPost.fromMap(jobPost);
      }).toList();
      notifyListeners();
    });
  }
}
