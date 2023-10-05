import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/job_posts_provider.dart';
import '../../common_views/components/animations/index.dart';
import 'display_job_post_details.dart';

import 'package:blukers/views/common_views/components/loading_animation.dart';

class AnimateJobPostDetails extends StatelessWidget {
  const AnimateJobPostDetails({super.key});

  @override
  Widget build(BuildContext context) {
    JobPostsProvider jp = Provider.of<JobPostsProvider>(context);
    return jp.selectedJobPost == null
        // ? Center(child: LoadingAnimation())
        ? Center(
            child: MyAnimation(
            name: 'blukersLoadingDots',
          ))
        : JobPostDetailsWidget(
            jobPost: jp.selectedJobPost,
          );
  }
}
