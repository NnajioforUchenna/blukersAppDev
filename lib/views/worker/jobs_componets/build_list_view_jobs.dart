import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common_files/constants.dart';
import '../../../models/job_post.dart';
import '../../../providers/job_posts_provider.dart';
import '../../../services/responsive.dart';
import 'display_job_card.dart';
import 'display_job_post_dialog.dart';

class BuildListViewJobs extends StatelessWidget {
  const BuildListViewJobs({super.key});

  @override
  Widget build(BuildContext context) {
    JobPostsProvider jp = Provider.of<JobPostsProvider>(context);
    final List<JobPost> jobPosts = jp.selectedJobPosts;
    return ListView.separated(
      shrinkWrap: true,
      padding:
          const EdgeInsets.all(10), // Added to give some space around cards
      itemCount: jobPosts.length,
      itemBuilder: (context, index) {
        JobPost jobPost = jobPosts[index];
        // Todo Remember to remove the default values
        return DisplayJobCard(
            timeAgo: jobPost.timeAgo,
            title: jobPost.jobTitle,
            salaryRange: jobPost.salaryAmount.toString(),
            salaryType: getSalaryType(jobPost.salaryType) ?? 'Salary Type',
            companyName: jobPost.companyName ?? 'Company Name',
            location: jobPost.location ?? 'Location',
            companyLogo: jobPost.companyLogo ?? 'https://picsum.photos/200/300',
            jobPostId: jobPost.companyId,
            onTap: () {
              if (Responsive.isDesktop(context)) {
                jp.setSelectedJobPost(jobPost);
              } else {
                showDialog(
                    context: context,
                    builder: (context) => DisplayJobPostDialog(
                          jobPost: jobPost,
                        ));
              }
            });
      },
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(
          height: 5,
        );
      },
    );
  }
}
