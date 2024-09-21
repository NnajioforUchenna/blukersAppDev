import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../providers/job_posts_provider.dart';
import '../../old_common_views/components/animations/index.dart';
import 'display_job_post_details.dart';

class AnimateJobPostDetails extends StatelessWidget {
  const AnimateJobPostDetails({super.key});

  @override
  Widget build(BuildContext context) {
    JobPostsProvider jp = Provider.of<JobPostsProvider>(context);

    if (jp.selectedJobPost != null) {
      return JobPostDetailsWidget(
        jobPost: jp.selectedJobPost,
      );
    } else if (jp.selectedJobPost == null) {
      return Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/icons/empty_job.svg',
          ),
          const SizedBox(height: 38),
          Text(
            'Click on Job to view',
            style: GoogleFonts.montserrat(
              fontSize: 16,
            ),
          ),
        ],
      ));
    } else if (jp.displayedJobPosts.isNotEmpty) {
      return JobPostDetailsWidget(
        jobPost: jp.displayedJobPosts.values.first,
      );
    } else {
      return const Center(
          child: MyAnimation(
        name: 'blukersLoadingDots',
      ));
    }
  }
}
