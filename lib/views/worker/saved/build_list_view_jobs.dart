import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data_providers/push_notification.dart';
import '../../../models/job_post.dart';
import '../../../providers/job_posts_provider.dart';
import '../../../providers/user_provider_parts/user_provider.dart';
import '../../../services/responsive.dart';
import '../../old_common_views/components/animations/index.dart';
import 'animate_job_post_details.dart';
import 'display_job_card.dart';
import 'display_job_post_dialog.dart';
import 'job_alert_manager.dart';
import 'no_more_jobs_found_card.dart';

class ListViewBuildJobs extends StatefulWidget {
  final String? title;
  final String? JobId;

  const ListViewBuildJobs({super.key, this.title, this.JobId});

  @override
  State<ListViewBuildJobs> createState() => _ListViewBuildJobsState();
}

class _ListViewBuildJobsState extends State<ListViewBuildJobs> {
  final ScrollController controller = ScrollController();
  bool isRefilling = false;
  late List<JobPost> jobPosts;
  int counter = 0;
  bool _isAlertOn = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> refill() async {
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
    super.initState();
    JobPostsProvider jp = Provider.of<JobPostsProvider>(context, listen: false);
    jobPosts = jp.displayedJobPosts.values.toList();

    controller.addListener(() async {
      if (controller.position.pixels == controller.position.maxScrollExtent &&
          jp.hasMore) {
        if (!isRefilling) {
          isRefilling = true;
          refill();
        }
      }
    });

    JobAlertManager(context, widget.JobId).loadAlertState().then((alertStatus) {
      setState(() {
        _isAlertOn = alertStatus;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    JobPostsProvider jp = Provider.of<JobPostsProvider>(context);


    return Column(
      children: [
        Container(
          height: 70,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: const Color.fromARGB(0, 255, 255, 255),
            border: Border(
              bottom: BorderSide(color: Colors.grey.shade300, width: 1),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        widget.title ?? '',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text('${jobPosts.length} results'),
                  ],
                ),
              ),
              Text(_isAlertOn ? 'Alerts On' : 'Alerts Off'),
              const SizedBox(width: 8),
              Switch(
                value: _isAlertOn,
                onChanged: (bool value) async {
                  await JobAlertManager(context, widget.JobId)
                      .toggleAlert(value);
                  setState(() {
                    _isAlertOn = value;
                  });
                },
                activeColor: Colors.green,
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.separated(
            controller: controller,
            shrinkWrap: true,
            padding: const EdgeInsets.all(10),
            itemCount: jobPosts.length + 1,
            itemBuilder: (context, index) {
              if (index < jobPosts.length) {
                JobPost jobPost = jobPosts[index];
                return DisplayJobCard(
                  jobPost: jobPost,
                  onTap: () {
                    jp.setSelectedJobPost(jobPost);
                    if (Responsive.isMobile(context)) {
                      showDialog(
                        context: context,
                        builder: (context) =>
                            DisplayJobPostDialog(jobPost: jobPost),
                      );
                    }
                  },
                );
              } else if (jp.hasMore) {
                if (!isRefilling) refill();
                return const Center(
                  child: SizedBox(
                    height: 400,
                    child: Padding(
                      padding: EdgeInsets.all(32.0),
                      child: Center(
                        child: MyAnimation(name: 'blukersLoadingDots'),
                      ),
                    ),
                  ),
                );
              } else {
                return NoJobsFoundCard(
                  nameSearch: jp.nameSearch,
                  locationSearch: jp.locationSearch,
                );
              }
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(height: 5);
            },
          ),
        ),
      ],
    );
  }
}

class BuildListViewJobs extends StatelessWidget {
  final String title;
  final String JobId;

  const BuildListViewJobs(
      {super.key, required this.title, required this.JobId});

  @override
  Widget build(BuildContext context) {
    return ListViewBuildJobs(
      title: title,
      JobId: JobId,
    );
  }
}

class BuildListViewJobsDesktop extends StatelessWidget {
  const BuildListViewJobsDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1st column
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListViewBuildJobs(),
          ),
        ),
        // 2nd column
        const Expanded(
          flex: 2,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(child: AnimateJobPostDetails()),
          ),
        ),
      ],
    );
  }
}
