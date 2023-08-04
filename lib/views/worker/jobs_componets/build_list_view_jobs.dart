import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common_files/constants.dart';
import '../../../models/job_post.dart';
import '../../../providers/job_posts_provider.dart';
import '../../../services/responsive.dart';
import 'display_card.dart';
import 'display_job_post_dialog.dart';

class BuildListViewJobs extends StatelessWidget {
  const BuildListViewJobs({super.key});

  @override
  Widget build(BuildContext context) {
    JobPostsProvider jp = Provider.of<JobPostsProvider>(context);
    final List<JobPost> jobPosts = jp.selectedJobPosts;
    return ListView.separated(
      padding:
          const EdgeInsets.all(10), // Added to give some space around cards
      itemCount: jobPosts.length,
      itemBuilder: (context, index) {
        final jobPost = jobPosts[index];
        print(jobPost);
        print('timeAgo: ${jobPost.timeAgo}');
        print('jobTitle: ${jobPost.jobTitle}');
        print('salaryAmount: ${jobPost.salaryAmount}');
        print('salaryTypeId: ${jobPost.salaryTypeId}');
        print('companyName: ${jobPost.companyName}');
        print('addresses: ${getAddressesInStringFormat(jobPost.addresses)}');
        print('companyLogo: ${jobPost.companyLogo}');
        print('_________________________');
        print('');

        return DisplayCard(
            timeAgo: jobPost.timeAgo,
            title: jobPost.jobTitle,
            salaryRange: jobPost.salaryAmount.toString(),
            salaryType: jobPost.salaryTypeId,
            companyName: jobPost.companyName,
            location: getAddressesInStringFormat(jobPost.addresses),
            companyLogo: jobPost.companyLogo,
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
