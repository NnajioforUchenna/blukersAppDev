import '../../../providers/job_posts_provider.dart';
import '../../../utils/styles/index.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';

import '../../../services/responsive.dart';
import '../../common_vieiws/icon_text_404.dart';
import '../../common_vieiws/loading_page.dart';
import 'animate_job_post_details.dart';
import 'build_list_view_jobs.dart';
import 'choose_target_language.dart';
import 'job_search_bar.dart';

class DisplayJobs extends StatelessWidget {
  final String title;
  final String JobId;

  const DisplayJobs({super.key, required this.title, required this.JobId});

  @override
  Widget build(BuildContext context) {
    JobPostsProvider jp = Provider.of<JobPostsProvider>(context);
    return WillPopScope(
      onWillPop: () {
        jp.clearSearchParameters();
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: ThemeColors.primaryThemeColor,
            iconTheme: const IconThemeData(
              color: Colors.white,
            ),
            elevation: 0,
            title: Text(
              '$title (Jobs)',
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            )),
        backgroundColor: const Color(0xFFF5F5F8),
        body: jp.displayedJobPosts.isEmpty
            ? jp.searchComplete
                ? const IconText404(
                    icon: UniconsLine.file_edit_alt,
                    text: "No job posts found",
                  )
                : const LoadingPage()
            : Responsive.isDesktop(context)
                ? buildWebContent()
                : BuildListViewJobs(
                    title: title,
                    JobId: JobId,
                  ),
      ),
    );
  }

  Widget buildWebContent() {
    return  Column(
      children: [
        const JobSearchBar(),
        const SizedBox(height: 10),
        const Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Spacer(),
            SizedBox(height: 50, width: 200, child: ChooseTargetLanguage()),
            SizedBox(width: 30)
          ],
        ),
        const SizedBox(height: 10),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1st column
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: BuildListViewJobs( title: title, JobId: JobId),
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
          ),
        ),
      ],
    );
  }
}
