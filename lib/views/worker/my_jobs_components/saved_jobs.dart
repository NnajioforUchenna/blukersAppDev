import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/job_post.dart';
import '../../../providers/job_posts_provider.dart';
import '../../../providers/user_provider.dart';
import '../jobs_componets/complete_job_posts_widget.dart';

class SavedJobs extends StatefulWidget {
  const SavedJobs({super.key});

  @override
  State<SavedJobs> createState() => _SavedJobsState();
}

class _SavedJobsState extends State<SavedJobs> {
  late Future<List<JobPost>> jobPosts;

  @override
  void initState() {
    super.initState();
    final up = Provider.of<UserProvider>(context, listen: false);
    final jpp = Provider.of<JobPostsProvider>(context, listen: false);
    if (up.appUser != null) {
      jobPosts = jpp.getSavedJobPostIds(up.appUser!.uid);
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
          return snapshot.data == null
              ? Text('No Saved Data')
              : CompleteJobPostWidget(
                  jobPosts: snapshot.data!,
                );
        }
        return Text('No job posts found');
      },
    );
  }
}
