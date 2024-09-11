import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../models/job_post.dart';
import '../../../../providers/job_posts_provider.dart';
import '../../../../services/responsive.dart';
import '../saved/animate_job_post_details.dart';
import '../saved/display_job_card.dart';
import '../saved/display_job_post_dialog.dart';
import '../saved/savedandapply_job_card.dart';

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
        flex: 1, // Ensure both columns are equally sized
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListViewJobs(
            jobPosts: jobPosts,
          ),
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
      padding: const EdgeInsets.all(10),
      itemCount: jobPosts.length,
      itemBuilder: (context, index) {
        JobPost jobPost = jobPosts[index];

        return Align(
          alignment: Alignment.centerLeft, // Align it to the left
          child: Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context)
                  .size
                  .width, // Set max width to screen width
            ),
            child: SavedandapplyJobCard(
              jobPost: jobPost,
              onTap: () {
                jp.setSelectedJobPost(jobPost);

                showDialog(
                    context: context,
                    builder: (context) => DisplayJobPostDialog(
                          jobPost: jobPost,
                        ));
              },
            ),
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
