import 'package:cloud_firestore/cloud_firestore.dart';

import 'job_post.dart';

class JobsPage {
  int displayAllJobsPage;
  DocumentSnapshot? lastDocument;
  List<JobPost> jobs;

  JobsPage({
    this.displayAllJobsPage = 0,
    this.lastDocument,
    List<JobPost>? jobs,
  }) : jobs = jobs ?? [];
}
