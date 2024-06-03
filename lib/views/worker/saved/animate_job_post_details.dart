import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/job_posts_provider.dart';
import '../../old_common_views/components/animations/index.dart';
import 'display_job_post_details.dart';

class AnimateJobPostDetails extends StatelessWidget {
  const AnimateJobPostDetails({super.key});

  @override
  Widget build(BuildContext context) {
    JobPostsProvider jp = Provider.of<JobPostsProvider>(context);
    return jp.selectedJobPost == null
        ? const Center(
            child: MyAnimation(
            name: 'blukersLoadingDots',
          ))
        : JobPostDetailsWidget(
            jobPost: jp.selectedJobPost,
          );
  }
}
