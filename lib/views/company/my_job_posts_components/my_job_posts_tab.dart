import 'package:bulkers/models/job_post.dart';
import 'package:bulkers/providers/company_provider.dart';
import 'package:bulkers/providers/job_posts_provider.dart';
import 'package:bulkers/views/worker/jobs_componets/complete_job_posts_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'my_job_post_component/loading_my_job_posts.dart';
import 'my_job_post_component/no_job_posts.dart';

class MyJobPostsTab extends StatelessWidget {
  const MyJobPostsTab({super.key});

  @override
  Widget build(BuildContext context) {
    CompanyProvider cp = Provider.of<CompanyProvider>(context);
    JobPostsProvider jpp = Provider.of<JobPostsProvider>(context);

    return StreamBuilder<List<JobPost>>(
      stream: cp
          .getMyJobPostsStream(), // Assuming CompanyProvider has a similar function to fetch the job posts stream.
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingMyJobPosts();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return NoMyJobPosts();
        } else {
          List<JobPost> jobPosts = snapshot.data!;
          return CompleteJobPostWidget(jobPosts: jobPosts);
        }
      },
    );
  }
}
