import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../../../../../providers/app_settings_provider.dart';
import '../../../../../../providers/industry_provider.dart';
import '../../../../../../providers/job_posts_provider.dart';
import '../../../../../common_vieiws/loading_page.dart';
import '../../../../../old_common_views/select_industry_components/display_industries.dart';
import '../../../../search_jobs/job_search_bar_components/job_all_search_bar.dart';
import '../../../../search_jobs/jobs_search_result_page/job_search_result_page.dart';

class SelectOrSearchJobsDesktop extends StatefulWidget {
  const SelectOrSearchJobsDesktop({super.key});

  @override
  State<SelectOrSearchJobsDesktop> createState() =>
      _SelectOrSearchJobsDesktopState();
}

class _SelectOrSearchJobsDesktopState extends State<SelectOrSearchJobsDesktop> {
  @override
  late AppSettingsProvider asp;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final prefs = await SharedPreferences.getInstance();
      final hasShowcased =
          prefs.getBool('showcaseShown') ?? false; // Default to false

      if (!hasShowcased) {
        final asp = Provider.of<AppSettingsProvider>(context, listen: false);
        final showcase = ShowCaseWidget.of(context);
        showcase.startShowCase([
          asp.signInButton,
          asp.bottomNavigation,
          asp.searchBar,
          asp.selection,
          asp.translation,
        ]);
        await prefs.setBool('showcaseShown', true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    IndustriesProvider ip = Provider.of<IndustriesProvider>(context);
    JobPostsProvider jp = Provider.of<JobPostsProvider>(context);
    asp = Provider.of<AppSettingsProvider>(context);
    final screenWidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(width: screenWidth * 0.6, child: const JobAllSearchBar()),
          const SizedBox(
            height: 10,
          ),
          AnimatedCrossFade(
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
                    child: const DisplayIndustries()),
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
