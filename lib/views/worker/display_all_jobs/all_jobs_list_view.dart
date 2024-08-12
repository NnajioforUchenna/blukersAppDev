import 'package:blukers/providers/job_posts_provider.dart';
import 'package:blukers/providers/jobs_lists_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/job_post.dart';
import '../../../services/responsive.dart';
import '../../old_common_views/components/animations/index.dart';
import '../saved/display_job_card.dart';
import '../saved/display_job_post_dialog.dart';
import '../saved/no_more_jobs_found_card.dart';

class AllJobsListView extends StatefulWidget {
  const AllJobsListView({super.key});

  @override
  State<AllJobsListView> createState() => _AllJobsListViewState();
}

class _AllJobsListViewState extends State<AllJobsListView> {
  final ScrollController controller = ScrollController();
  bool isRefilling = false;
  late List<JobPost> jobPosts;
  int counter = 0;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  refill() async {
    JobsListsProvider jlp =
        Provider.of<JobsListsProvider>(context, listen: false);
    Map<String, JobPost> newJobs = await jlp.loadMoreAllJobs();
    setState(() {
      jobPosts.addAll(newJobs.values.toList());
    });
    isRefilling = false;
  }

  @override
  void initState() {
    JobsListsProvider jlp =
        Provider.of<JobsListsProvider>(context, listen: false);
    jobPosts = jlp.displayAllJobs.values.toList();
    controller.addListener(() async {
      if (controller.position.pixels == controller.position.maxScrollExtent) {
        if (jlp.hasMore) {
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
    JobsListsProvider jlp = Provider.of<JobsListsProvider>(context);
    counter++;
    print(counter);

    return ListView.separated(
      controller: controller,
      shrinkWrap: true,
      padding: const EdgeInsets.all(10),
      // Added to give some space around cards
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
          if (jlp.hasMore) {
            if (!isRefilling) {
              isRefilling = true;
              refill();
            }
          }

          return jlp.hasMore
              ? const Center(
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
              : const NoJobsFoundCard(
                  nameSearch: 'Jobs',
                  locationSearch: 'USA',
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
