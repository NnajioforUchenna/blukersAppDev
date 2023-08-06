import 'package:bulkers/providers/user_provider.dart';
import 'package:bulkers/views/worker/jobs_componets/detail_page_block_four.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/job_post.dart';
import '../../../providers/job_posts_provider.dart';
import '../../../utils/styles/theme_colors.dart';
import '../../common_views/loading_page.dart';
import 'detail_page_block_one.dart';
import 'detail_page_block_three.dart';
import 'detail_page_block_two.dart';

// Assuming you've imported the required classes (JobPost, Skill, Address) above
class JobPostDetailsWidget extends StatelessWidget {
  const JobPostDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    JobPostsProvider jp = Provider.of<JobPostsProvider>(context);
    UserProvider up = Provider.of<UserProvider>(context);
    JobPost? jobPost = jp.selectedJobPost;
    return jobPost == null
        ? Center(child: SizedBox(height: 100, width: 100, child: LoadingPage()))
        : Container(
            margin: const EdgeInsets.symmetric(
                horizontal: 16), // Adjusted the margin
            child: Card(
                elevation: 5,
                child: AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          width: 2,
                          color: ThemeColors.primaryThemeColor,
                        ),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          DetailPageBlockOne(jobPost: jobPost),
                          DetailPageBlockTwo(jobPost: jobPost),
                          DetailPageBlockThree(jobPost: jobPost),
                          DetailPageBlockFour(jobPost: jobPost),
                        ],
                      ),
                    ))),
          );
  }
}
