import '../../../../../providers/industry_provider.dart';
import '../../../../../providers/job_posts_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../common_vieiws/loading_page.dart';
import '../../../saved/job_search_result_page.dart';
import 'jobs_mobile_view_compnents/mobile_display_industries.dart';
import 'jobs_mobile_view_compnents/search_and_translate_row.dart';
import 'jobs_mobile_view_compnents/sign_in_row.dart';

class JobsPageMobile extends StatelessWidget {
  const JobsPageMobile({super.key});

  @override
  Widget build(BuildContext context) {
    IndustriesProvider ip = Provider.of<IndustriesProvider>(context);
    JobPostsProvider jp = Provider.of<JobPostsProvider>(context);
    return Column(
      children: [
        const SignInRow(),
        const SearchAndTranslateRow(),
        Expanded(
          child: AnimatedCrossFade(
            firstChild: ip.industries.isEmpty
                ? const LoadingPage()
                : const MobileDisplayIndustries(),
            secondChild: const JobSearchResultPage(),
            crossFadeState: jp.isSearching
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 500),
          ),
        ),
      ],
    );
  }
}
