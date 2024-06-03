
import 'package:blukers/views/worker/worker_home/worker_home_components/jobs_desktop_view/select_desktop_language_dialog.dart';
import '../../../../../providers/industry_provider.dart';
import '../../../../../providers/job_posts_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../common_vieiws/all_search_bar_components/all_worker_search_bar.dart';
import '../../../../common_vieiws/loading_page.dart';
import '../../../../old_common_views/select_industry_components/display_industries.dart';
import '../../../saved/job_search_result_page.dart';

class JobsPageDesktop extends StatefulWidget {
  const JobsPageDesktop({Key? key}) : super(key: key);

  @override
  State<JobsPageDesktop> createState() => _JobsPageDesktopState();

}
class _JobsPageDesktopState extends State<JobsPageDesktop> {
   
  @override
 Widget build(BuildContext context) {
  IndustriesProvider ip = Provider.of<IndustriesProvider>(context);
  JobPostsProvider jp = Provider.of<JobPostsProvider>(context);
  return SingleChildScrollView(
    child: Column(
      children: [
        const AllSearchBar(),
        const SizedBox(
          height: 10,
        ),
        const Center(
          child: SelectDesktopLanguageDialog(),
        ),
        const SizedBox(
          height: 10,
        ),
        const Divider(),
        AnimatedCrossFade(
          firstChild: ip.industries.isEmpty
              ? const LoadingPage()
              : const DisplayIndustries(),
          secondChild: const JobSearchResultPage(),
          crossFadeState: jp.isSearching
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 500),
        ),
      ],
    ),
  );
}
}