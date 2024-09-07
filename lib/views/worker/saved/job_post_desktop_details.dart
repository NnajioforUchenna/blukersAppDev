import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/job_post.dart';
import '../../../providers/user_provider_parts/user_provider.dart';
import '../../../utils/styles/theme_colors.dart';
import 'desktop_job_post_details_component/detail_page_block_five.dart';
import 'desktop_job_post_details_component/detail_page_block_four.dart';
import 'desktop_job_post_details_component/detail_page_block_one.dart';
import 'desktop_job_post_details_component/detail_page_block_three.dart';
import 'desktop_job_post_details_component/detail_page_block_two.dart';
import 'desktop_job_post_details_component/detail_page_book_six.dart';

class JobPostDesktopDetails extends StatelessWidget {
  final JobPost jobPost;
  final Animation<double> animation;

  const JobPostDesktopDetails(
      {super.key, required this.jobPost, required this.animation});

  @override
  Widget build(BuildContext context) {
    UserProvider up = Provider.of<UserProvider>(context);
    return Card(
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              width: 2,
              color: ThemeColors.primaryThemeColor,
            ),
          ),
        ),
        child: FadeTransition(
          opacity: animation,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                DetailPageBlockOne(jobPost: jobPost),
                DetailPageBlockTwo(jobPost: jobPost),
                DetailPageBlockThree(jobPost: jobPost),
                DetailPageBlockFour(jobPost: jobPost),
                DetailPageBlockSix(jobPost: jobPost),
                if (up.appUser != null && up.appUser!.uid == jobPost.companyId)
                  DetailPageBlockFive(jobPost: jobPost),
                if (!kIsWeb) const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
