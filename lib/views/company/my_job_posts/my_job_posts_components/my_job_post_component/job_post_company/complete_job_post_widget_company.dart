import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../models/job_post.dart';
import '../../../../../../providers/job_posts_provider.dart';
import '../../../../../../providers/user_provider_parts/user_provider.dart';
import '../../../../../../services/responsive.dart';
import '../../../../../old_common_views/components/animations/index.dart';
import '../../../../../worker/saved/animate_job_post_details.dart';
import '../../../../../worker/saved/display_job_card.dart';
import '../../../../../worker/saved/no_more_jobs_found_card.dart';
import 'display_job_post_dialog_company.dart';
import 'job_post_mobile_details_company.dart';

class CompanyCompleteJobPostWidget extends StatefulWidget {
  final List<JobPost> jobPosts;

  const CompanyCompleteJobPostWidget({super.key, required this.jobPosts});

  @override
  State<CompanyCompleteJobPostWidget> createState() =>
      _CompanyCompleteJobPostWidgetState();
}

class _CompanyCompleteJobPostWidgetState
    extends State<CompanyCompleteJobPostWidget> {
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
                companyId: widget.jobPosts.first.companyId,
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
            companyId: jobPosts.first.companyId,
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
  final String companyId;

  const ListViewJobs({
    Key? key,
    required this.jobPosts,
    required this.companyId,
  }) : super(key: key);

  @override
  State<ListViewJobs> createState() => _ListViewJobsState();
}

class _ListViewJobsState extends State<ListViewJobs> {
  final ScrollController controller = ScrollController();
  bool isRefilling = false;
  late JobPostsProvider jp;
  late List<JobPost> filteredJobPosts;

  @override
  void initState() {
    super.initState();
    jp = Provider.of<JobPostsProvider>(context, listen: false);
    filterJobPosts();
    controller.addListener(_scrollListener);
  }

  void filterJobPosts() {
    filteredJobPosts = widget.jobPosts
        .where((job) => job.companyId == widget.companyId)
        .toList();
  }

  void _scrollListener() {
    if (controller.position.pixels == controller.position.maxScrollExtent) {
      if (jp.hasMore && !isRefilling) {
        isRefilling = true;
        refill();
      }
    }
  }

  Future<void> refill() async {
    UserProvider up = Provider.of<UserProvider>(context, listen: false);

    Map<String, JobPost> newJobs = await jp.loadMoreJobPosts(
      pageNumber: filteredJobPosts.isEmpty ? 0 : filteredJobPosts.length ~/ 10,
      targetLanguage: up.userLanguage,
      queryName: jp.nameSearch,
      queryLocation: jp.locationSearch,
      // companyId: widget.companyId,
    );

    if (mounted) {
      setState(() {
        List<JobPost> newFilteredJobs = newJobs.values
            .where((job) => job.companyId == widget.companyId)
            .toList();
        filteredJobPosts.addAll(newFilteredJobs);
      });
    }

    isRefilling = false;
  }

  @override
  void dispose() {
    controller.removeListener(_scrollListener);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: controller,
      shrinkWrap: true,
      padding: const EdgeInsets.all(15),
      itemCount: filteredJobPosts.length + 1,
      itemBuilder: (context, index) {
        if (index < filteredJobPosts.length) {
          JobPost jobPost = filteredJobPosts[index];
          return DisplayJobCard(
            jobPost: jobPost,
            onTap: () {
              jp.setSelectedJobPost(jobPost);
              if (Responsive.isMobile(context)) {
                showDialog(
                  context: context,
                  builder: (context) => Container(
                    color: Colors.transparent,
                    child: JobPostMobileDetailsCompany(
                      jobPost: jobPost,
                    ),
                  ),
                );
              }
            },
          );
        } else {
          if (jp.hasMore && !isRefilling) {
            isRefilling = true;
            refill();
          }

          // return jp.hasMore
          //     ? const Center(
          //         child: SizedBox(
          //           height: 400,
          //           child: Padding(
          //             padding: EdgeInsets.all(32.0),
          //             child: Center(
          //               child: MyAnimation(
          //                 name: 'blukersLoadingDots',
          //               ),
          //             ),
          //           ),
          //         ),
          //       )
          //     : NoJobsFoundCard(
          //         nameSearch: jp.nameSearch,
          //         locationSearch: jp.locationSearch,
          //       );
        }
      },
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(height: 5);
      },
    );
  }
}
