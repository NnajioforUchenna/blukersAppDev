import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../../models/job_post.dart';
import '../../../../../providers/job_posts_provider.dart';
import '../../../../common_vieiws/loading_page.dart';
import '../../../worker_page_template/worker_page_template.dart';
import 'web_job_search_result_page.dart';

class WebSearchLandingPage extends StatelessWidget {
  const WebSearchLandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    JobPostsProvider jp = Provider.of<JobPostsProvider>(context);
    List<JobPost> toDisplay = jp.searchJobs.isNotEmpty
        ? jp.searchJobs.values.toList()
        : jp.recent50Jobs.isNotEmpty
            ? jp.recent50Jobs.values.toList()
            : [];
    return WorkerPageTemplate(
      child: SingleChildScrollView(
        child: Column(
          children: [
            // const WebSearchBar(),
            SizedBox(height: 10.w),
            toDisplay.isEmpty
                ? const LoadingPage()
                : WebJobSearchResultPage(toDisplay: toDisplay),
          ],
        ),
      ),
    );
  }
}
