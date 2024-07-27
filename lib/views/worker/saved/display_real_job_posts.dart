import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/job_post.dart';
import '../../../providers/job_posts_provider.dart';
import '../search_jobs/jobs_search_result_page/Components/complete_job_posts_widget.dart';

class DisplayRealJobPosts extends StatelessWidget {
  const DisplayRealJobPosts({super.key});

  @override
  Widget build(BuildContext context) {
    JobPostsProvider jp = Provider.of<JobPostsProvider>(context);
    List<JobPost> jobPosts = jp.displayedJobPosts.values.toList();

    return CompleteJobPostWidget(jobPosts: jobPosts);
  }
}
