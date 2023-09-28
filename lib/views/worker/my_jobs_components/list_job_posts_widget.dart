import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/job_post.dart';
import '../../../providers/job_posts_provider.dart';
import '../../../services/responsive.dart';
import '../jobs_componets/animate_job_post_details.dart';
import '../jobs_componets/display_job_card.dart';
import '../jobs_componets/display_job_post_dialog.dart';

class ListJobPostsWidget extends StatelessWidget {
  final List<JobPost> jobPosts;
  const ListJobPostsWidget({super.key, required this.jobPosts});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints:
            BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.8),
        child: Responsive.isDesktop(context)
            ? buildWebContent(jobPosts)
            : ListViewJobs(
                jobPosts: jobPosts,
              ));
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
          child: AnimateJobPostDetails(),
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
            jobPost: jobPost,
            onTap: () {
              jp.setSelectedJobPost(jobPost);
              if (Responsive.isMobile(context)) {
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
