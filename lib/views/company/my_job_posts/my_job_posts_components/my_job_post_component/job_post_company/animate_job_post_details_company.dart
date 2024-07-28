import 'package:blukers/views/company/my_job_posts/my_job_posts_components/my_job_post_component/job_post_company/job_post_details_widget_company.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../providers/job_posts_provider.dart';
import '../../../../../old_common_views/components/animations/index.dart';

class AnimateJobPostDetailsCompany extends StatelessWidget {
  const AnimateJobPostDetailsCompany({super.key});

  @override
  Widget build(BuildContext context) {
    JobPostsProvider jp = Provider.of<JobPostsProvider>(context);
    return jp.selectedJobPost == null
        ? const Center(
            child: MyAnimation(
            name: 'blukersLoadingDots',
          ))
        : JobPostDetailsWidgetCompany(
            jobPost: jp.selectedJobPost,
          );
  }
}
