import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/job_post.dart';
import '../../../providers/job_posts_provider.dart';
import '../../../services/responsive.dart';
import 'animate_job_post_details.dart';
import 'display_job_card.dart';
import 'display_job_post_dialog.dart';

class CompleteJobPostWidget extends StatefulWidget {
  final List<JobPost> jobPosts;

  const CompleteJobPostWidget({Key? key, required this.jobPosts})
      : super(key: key);

  @override
  State<CompleteJobPostWidget> createState() => _CompleteJobPostWidgetState();
}

class _CompleteJobPostWidgetState extends State<CompleteJobPostWidget> {
  @override
  void initState() {
    super.initState();
    JobPostsProvider jp = Provider.of<JobPostsProvider>(context, listen: false);
    if (widget.jobPosts.isNotEmpty) {
      jp.selectedJobPost = widget.jobPosts.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints:
            BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.8),
        child: Responsive.isDesktop(context)
            ? buildWebContent(widget.jobPosts)
            : ListViewJobs(
                jobPosts: widget.jobPosts,
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
          padding: const EdgeInsets.all(8.0),
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

class ListViewJobs extends StatefulWidget {
  final List<JobPost> jobPosts;
  const ListViewJobs({super.key, required this.jobPosts});

  @override
  State<ListViewJobs> createState() => _ListViewJobsState();
}

class _ListViewJobsState extends State<ListViewJobs> {
  final ScrollController controller = ScrollController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    controller.addListener(() {
      if (controller.position.pixels == controller.position.maxScrollExtent) {
        JobPostsProvider jp =
            Provider.of<JobPostsProvider>(context, listen: false);
        jp.loadMoreJobPosts();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    JobPostsProvider jp = Provider.of<JobPostsProvider>(context);
    return ListView.separated(
      controller: controller,
      shrinkWrap: true,
      padding:
          const EdgeInsets.all(10), // Added to give some space around cards
      itemCount: widget.jobPosts.length + 1,
      itemBuilder: (context, index) {
        if (index < widget.jobPosts.length) {
          JobPost jobPost = widget.jobPosts[index];
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
        } else {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 32.0),
            child: Center(child: CircularProgressIndicator()),
          );
        }
      },
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(
          height: 5,
        );
      },
    );
  }
}
