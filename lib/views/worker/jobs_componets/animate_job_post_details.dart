import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/job_posts_provider.dart';
import 'display_job_post_details.dart';

class AnimateJobPostDetails extends StatelessWidget {
  const AnimateJobPostDetails({super.key});

  @override
  Widget build(BuildContext context) {
    JobPostsProvider jp = Provider.of<JobPostsProvider>(context);
    return jp.selectedJobPost == null
        ? const Center(child: CircularProgressIndicator())
        : JobPostDetailsWidget(
            jobPost: jp.selectedJobPost,
          );
  }
}
