import 'package:blukers/models/job_post.dart';
import 'package:blukers/providers/company_provider.dart';
import 'package:blukers/providers/job_posts_provider.dart';
import 'package:blukers/views/worker/jobs_componets/complete_job_posts_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'my_job_post_component/loading_my_job_posts.dart';
import 'my_job_post_component/no_job_posts.dart';

import 'package:blukers/views/common_views/components/icon_text_404.dart';
import 'package:unicons/unicons.dart';

import 'package:blukers/views/common_views/components/animations/index.dart';

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
          // return LoadingMyJobPosts();
          return MyAnimation(name: 'circlePulseBlue2');
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          // return NoMyJobPosts();
          return IconText404(
              text: "You have not created any job post",
              icon: UniconsLine.file_alt);
        } else {
          List<JobPost> jobPosts = snapshot.data!;
          return CompleteJobPostWidget(jobPosts: jobPosts);
        }
      },
    );
  }
}
