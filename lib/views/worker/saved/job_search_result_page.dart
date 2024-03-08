import '../../../providers/job_posts_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/job_post.dart';
import 'complete_job_posts_widget.dart';

class JobSearchResultPage extends StatelessWidget {
  const JobSearchResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    JobPostsProvider jp = Provider.of<JobPostsProvider>(context);
    List<JobPost> jobPosts = jp.displayedJobPosts.values.toList();
    return CompleteJobPostWidget(jobPosts: jobPosts);
  }
}
