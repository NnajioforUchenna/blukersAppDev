import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common_files/constants.dart';
import '../../../models/job_post.dart';
import '../../../providers/job_posts_provider.dart';
import '../../../services/responsive.dart';
import 'display_job_card.dart';
import 'display_job_post_details.dart';
import 'display_job_post_dialog.dart';

class CompleteJobPostWidget extends StatelessWidget {
  final List<JobPost> jobPosts;

  const CompleteJobPostWidget({Key? key, required this.jobPosts})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Responsive.isDesktop(context)
        ? buildWebContent(jobPosts)
        : ListViewJobs(
            jobPosts: jobPosts,
          );
  }
}

Widget buildWebContent(jobPosts) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // 1st column
      Expanded(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: ListViewJobs(
            jobPosts: jobPosts,
          ),
        ),
      ),
      // 2nd column
      const Expanded(
        flex: 2,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: JobPostDetailsWidget(),
        ),
      ),
    ],
  );
}

class ListViewJobs extends StatelessWidget {
  final List<JobPost> jobPosts;
  const ListViewJobs({super.key, required this.jobPosts});

  @override
  Widget build(BuildContext context) {
    JobPostsProvider jp = Provider.of<JobPostsProvider>(context);
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
