import 'package:blukers/services/responsive.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/job_post.dart';
import '../../../providers/job_posts_provider.dart';
import '../../../providers/user_provider_parts/user_provider.dart';
import '../../common_views/components/animations/index.dart';
import 'display_job_card.dart';
import 'display_job_post_dialog.dart';
import 'no_more_jobs_found_card.dart';

class BuildListViewJobs extends StatefulWidget {
  const BuildListViewJobs({super.key});

  @override
  State<BuildListViewJobs> createState() => _BuildListViewJobsState();
}

class _BuildListViewJobsState extends State<BuildListViewJobs> {
  final ScrollController controller = ScrollController();
  bool isRefilling = false;
  late List<JobPost> jobPosts;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  refill() async {
    JobPostsProvider jp = Provider.of<JobPostsProvider>(context, listen: false);
    UserProvider up = Provider.of<UserProvider>(context, listen: false);
    Map<String, JobPost> newJobs = await jp.loadMoreJobPosts(
        pageNumber: jobPosts.isEmpty ? 0 : jobPosts.length ~/ 10,
        targetLanguage: up.userLanguage,
        queryName: jp.nameSearch,
        queryLocation: jp.locationSearch);
    setState(() {
      jobPosts.addAll(newJobs.values.toList());
    });
    isRefilling = false;
  }

  @override
  void initState() {
    JobPostsProvider jp = Provider.of<JobPostsProvider>(context, listen: false);
    jobPosts = jp.displayedJobPosts.values.toList();
    controller.addListener(() async {
      if (controller.position.pixels == controller.position.maxScrollExtent) {
        if (jp.hasMore) {
          if (!isRefilling) {
            isRefilling = true;
            refill();
          }
        }
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
          if (jp.hasMore) {
            if (!isRefilling) {
              isRefilling = true;
              refill();
            }
          }

          return jp.hasMore
              ? Center(
                  child: SizedBox(
                    height: 400,
                    child: Padding(
                      padding: EdgeInsets.all(32.0),
                      child: Center(
                          child: MyAnimation(
                        name: 'blukersLoadingDots',
                      )),
                    ),
                  ),
                )
              : NoJobsFoundCard(
                  nameSearch: jp.nameSearch,
                  locationSearch: jp.locationSearch,
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
