import 'package:blukers/views/worker/jobs_and_componets/jobs_mobile_view/search_and_translate_row.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/industry_provider.dart';
import '../../../../providers/job_posts_provider.dart';
import '../../../common_views/loading_page.dart';
import '../job_search_result_page.dart';
import 'mobile_display_industries.dart';
import 'sign_in_row.dart';

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
                ? LoadingPage()
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
