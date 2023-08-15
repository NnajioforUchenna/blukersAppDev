import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../providers/industry_provider.dart';
import '../../providers/job_posts_provider.dart';
import '../common_views/all_search_bar_components/all_search_bar.dart';
import '../common_views/loading_page.dart';
import '../common_views/page_template/page_template.dart';
import '../common_views/select_industry_components/display_industries.dart';
import 'jobs_componets/job_search_result_page.dart';

class Jobs extends StatelessWidget {
  const Jobs({super.key});

  @override
  Widget build(BuildContext context) {
    IndustriesProvider ip = Provider.of<IndustriesProvider>(context);
    JobPostsProvider jp = Provider.of<JobPostsProvider>(context);
    return PageTemplate(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const AllSearchBar(),
            SizedBox(height: 10.w),
            const Divider(),
            AnimatedCrossFade(
              firstChild: ip.industries.isEmpty
                  ? LoadingPage()
                  : const DisplayIndustries(),
              secondChild: const JobSearchResultPage(),
              crossFadeState: jp.isSearching
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 500),
            ),
          ],
        ),
      ),
    );
  }
}
