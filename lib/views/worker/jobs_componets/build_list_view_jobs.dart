import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/job_post.dart';
import '../../../providers/job_posts_provider.dart';
import '../../../services/responsive.dart';
import '../../../utils/styles/theme_colors.dart';
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
        return Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            side: const BorderSide(
                color: ThemeColors.primaryThemeColor, width: 2),
            borderRadius: BorderRadius.circular(15),
          ),
          margin: const EdgeInsets.symmetric(
              vertical: 10, horizontal: 0), // Adjust for spacing
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 15), // Add padding for larger appearance
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
            },
            title: Text(
              '${jobPost.jobTitle} ',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: ThemeColors.primaryThemeColor,
              ),
            ),
            subtitle: Text(jobPost.jobDescription),
            leading: Container(
              width: 50, // Adjust size as necessary
              height: 50, // Adjust size as necessary
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100), // Rounded rectangle
                  image: const DecorationImage(
                    image: NetworkImage("https://picsum.photos/200/300"),
                    fit: BoxFit.cover,
                  )),
            ),
            trailing: Text(jobPost.jobType.toString()),
            // Add more details for each worker, if needed
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(
          height: 5,
        );
      },
    );
  }
}
