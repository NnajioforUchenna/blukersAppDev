import 'package:blukers/services/responsive.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/job_post.dart';
import '../../../providers/job_posts_provider.dart';
import '../../../providers/user_provider.dart';
import 'display_job_card.dart';
import 'display_job_post_dialog.dart';

class BuildListViewJobs extends StatefulWidget {
  const BuildListViewJobs({super.key});

  @override
  State<BuildListViewJobs> createState() => _BuildListViewJobsState();
}

class _BuildListViewJobsState extends State<BuildListViewJobs> {
  final ScrollController controller = ScrollController();
  int pageNumber = 1;
  late List<JobPost> jobPosts;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    JobPostsProvider jp = Provider.of<JobPostsProvider>(context, listen: false);
    jobPosts = jp.selectedJobPosts;
    controller.addListener(() async {
      if (controller.position.pixels == controller.position.maxScrollExtent) {
        UserProvider up = Provider.of<UserProvider>(context, listen: false);
        String targetLanguage = up.userLanguage;
        Map<String, JobPost> newJobs = await jp.loadMoreJobPosts(
            pageNumber: pageNumber,
            targetLanguage: targetLanguage,
            queryName: jp.nameSearch,
            queryLocation: jp.locationSearch);
        setState(() {
          jobPosts.addAll(newJobs.values.toList());
          pageNumber++;
        });
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
      itemCount: jobPosts.length + 1,
      itemBuilder: (context, index) {
        if (index < jobPosts.length) {
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
