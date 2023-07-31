import 'package:bulkers/providers/job_posts_provider.dart';
import 'package:bulkers/utils/styles/index.dart';
import 'package:bulkers/views/common_views/loading_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../services/responsive.dart';
import 'build_list_view_jobs.dart';
import 'display_job_post.dart';

class DisplayJobs extends StatelessWidget {
  final String title;

  const DisplayJobs({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    JobPostsProvider jp = Provider.of<JobPostsProvider>(context);
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(
            color: ThemeColors.primaryThemeColor,
          ),
          elevation: 0,
          title: Text(
            '$title (Jobs)',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: ThemeColors.primaryThemeColor,
            ),
          )),
      body: jp.selectedJobPosts.isEmpty
          ? LoadingPage()
          : Responsive.isDesktop(context)
              ? buildWebContent()
              : const BuildListViewJobs(),
    );
  }

  Widget buildWebContent() {
    return const Row(
      crossAxisAlignment: CrossAxisAlignment.center,
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
            child: JobPostWidget(),
          ),
        ),
      ],
    );
  }
}
