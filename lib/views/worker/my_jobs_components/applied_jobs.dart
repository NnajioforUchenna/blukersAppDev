import 'package:bulkers/providers/job_posts_provider.dart';
import 'package:bulkers/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/job_post.dart';
import '../jobs_componets/complete_job_posts_widget.dart';

class AppliedJobs extends StatefulWidget {
  const AppliedJobs({Key? key}) : super(key: key); // Corrected here

  @override
  State<AppliedJobs> createState() => _AppliedJobsState();
}

class _AppliedJobsState extends State<AppliedJobs> {
  late Future<List<JobPost>>
      jobPosts; // Changed to late as it is initialized in initState

  @override
  void initState() {
    super.initState();
    final up = Provider.of<UserProvider>(context, listen: false);
    final jpp = Provider.of<JobPostsProvider>(context, listen: false);
    if (up.appUser != null) {
      jobPosts = jpp.getAppliedJobPostIds(up.appUser!.uid!);
    } else {
      jobPosts = Future.value([]); // It's better to initialize in this way
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<JobPost>>(
      future: jobPosts,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          return CompleteJobPostWidget(
            jobPosts: snapshot.data!,
          );
        }
        return Text('No job posts found');
      },
    );
  }
}
