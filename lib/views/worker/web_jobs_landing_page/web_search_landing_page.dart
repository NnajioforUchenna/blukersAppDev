import 'package:bulkers/models/job_post.dart';
import 'package:bulkers/providers/job_posts_provider.dart';
import 'package:bulkers/views/common_views/page_template/page_template.dart';
import 'package:bulkers/views/worker/web_jobs_landing_page/web_job_search_result_page.dart';
import 'package:bulkers/views/worker/web_jobs_landing_page/web_landing_page_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../common_views/loading_page.dart';

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
    return PageTemplate(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const WebSearchBar(),
            SizedBox(height: 10.w),
            toDisplay.isEmpty
                ? LoadingPage()
                : WebJobSearchResultPage(toDisplay: toDisplay),
          ],
        ),
      ),
    );
  }
}
