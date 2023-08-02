import 'package:bulkers/models/job_post.dart';
import 'package:bulkers/providers/company_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/styles/theme_colors.dart';
import 'my_job_post_component/loading_my_job_posts.dart';
import 'my_job_post_component/no_job_posts.dart';

class MyJobPostsTab extends StatelessWidget {
  const MyJobPostsTab({super.key});

  @override
  Widget build(BuildContext context) {
    CompanyProvider cp = Provider.of<CompanyProvider>(context);
// Using the hypothetical JobPostProvider

    return StreamBuilder<List<JobPost>>(
      stream: cp
          .getMyJobPostsStream(), // Assuming CompanyProvider has a similar function to fetch the job posts stream.
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingMyJobPosts();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return NoMyJobPosts();
        } else {
          List<JobPost> jobPosts = snapshot.data!;
          return ListView.separated(
            padding: const EdgeInsets.all(10),
            itemCount: jobPosts.length,
            itemBuilder: (context, index) {
              JobPost jobPost = jobPosts[index];
              return Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                      color: ThemeColors.primaryThemeColor, width: 2),
                  borderRadius: BorderRadius.circular(15),
                ),
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 15,
                  ),
                  onTap: () {
                    // if (Responsive.isDesktop(context)) {
                    //   jp.setSelectedJobPost(jobPost); // Assuming JobPostProvider has a similar function to WorkerProvider
                    // } else {
                    //   showDialog(
                    //     context: context,
                    //     builder: (context) => DisplayJobPostDialog(
                    //       jobPost: jobPost, // Display job post details in a dialog
                    //     ),
                    //   );
                    // }
                  },
                  title: Text(
                    '${jobPost.jobTitle} at ${jobPost.companyName}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: ThemeColors.primaryThemeColor,
                    ),
                  ),
                  subtitle: Text(jobPost.jobDescription),
                  leading: jobPost.companyImageUrl != null
                      ? Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            image: DecorationImage(
                              image: NetworkImage(jobPost.companyImageUrl!),
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      : null, // Display company image if available
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
      },
    );
  }
}
