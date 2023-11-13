import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/industry_provider.dart';
import '../../../../providers/job_posts_provider.dart';
import '../../../common_views/all_search_bar_components/all_search_bar.dart';
import '../../../common_views/loading_page.dart';
import '../../../common_views/select_industry_components/display_industries.dart';
import '../choose_target_language.dart';
import '../job_search_result_page.dart';

class JobsPageDesktop extends StatelessWidget {
  const JobsPageDesktop({super.key});

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
            child: ChooseTargetLanguage(),
          ),
          const SizedBox(
            height: 10,
          ),
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
    );
  }
}
