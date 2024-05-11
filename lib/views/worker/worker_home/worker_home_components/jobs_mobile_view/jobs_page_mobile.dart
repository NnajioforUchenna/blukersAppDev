import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../../../../providers/app_settings_provider.dart';
import '../../../../../providers/industry_provider.dart';
import '../../../../../providers/job_posts_provider.dart';
import '../../../../common_vieiws/loading_page.dart';
import '../../../saved/job_search_result_page.dart';
import 'jobs_mobile_view_compnents/mobile_display_industries.dart';
import 'jobs_mobile_view_compnents/search_and_translate_row.dart';
import 'jobs_mobile_view_compnents/sign_in_row.dart';

class JobsPageMobile extends StatefulWidget {
  const JobsPageMobile({super.key});

  @override
  State<JobsPageMobile> createState() => _JobsPageMobileState();
}

class _JobsPageMobileState extends State<JobsPageMobile> {
  late AppSettingsProvider asp;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final asp = Provider.of<AppSettingsProvider>(context, listen: false);
      if (!asp.hasShowcased) {
        final showcase = ShowCaseWidget.of(context);
        showcase.startShowCase([
          asp.signInButton,
          asp.bottomNavigation,
          asp.searchBar,
          asp.selection,
          asp.translation,
        ]);
        asp.setHasShowcased(true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    IndustriesProvider ip = Provider.of<IndustriesProvider>(context);
    JobPostsProvider jp = Provider.of<JobPostsProvider>(context);
    asp = Provider.of<AppSettingsProvider>(context);

    return Column(
      children: [
        const SignInRow(),
        const SearchAndTranslateRow(),
        Expanded(
          child: AnimatedCrossFade(
            firstChild: ip.industries.isEmpty
                ? const LoadingPage()
                : Showcase(
                    key: asp.selection,
                    description: 'Use this section to Select Jobs by industry',
                    targetShapeBorder: const CircleBorder(),
                    overlayOpacity: 0.6,
                    tooltipBackgroundColor:
                        const Color.fromRGBO(30, 117, 187, 1),
                    descTextStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    child: const MobileDisplayIndustries()),
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
