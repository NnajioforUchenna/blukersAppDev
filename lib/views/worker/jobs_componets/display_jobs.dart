import 'package:blukers/providers/job_posts_provider.dart';
import 'package:blukers/utils/styles/index.dart';
import 'package:blukers/views/common_views/loading_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';

import '../../../services/responsive.dart';
import '../../common_views/components/icon_text_404.dart';
import 'animate_job_post_details.dart';
import 'build_list_view_jobs.dart';
import 'choose_target_language.dart';
import 'job_search_bar.dart';

class DisplayJobs extends StatelessWidget {
  final String title;

  const DisplayJobs({super.key, required this.title});

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
                ? IconText404(
                    icon: UniconsLine.file_edit_alt,
                    text: "No job posts found",
                  )
                : LoadingPage()
            : Responsive.isDesktop(context)
                ? buildWebContent()
                : const BuildListViewJobs(),
      ),
    );
  }

  Widget buildWebContent() {
    return Column(
      children: [
        JobSearchBar(),
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
        const Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1st column
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: BuildListViewJobs(),
                ),
              ),
              // 2nd column
              Expanded(
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
