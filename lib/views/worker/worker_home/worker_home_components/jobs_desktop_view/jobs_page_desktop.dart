
import 'package:blukers/views/worker/worker_home/worker_home_components/jobs_desktop_view/select_desktop_language_dialog.dart';
import 'package:blukers/views/worker/worker_home/worker_home_components/jobs_mobile_view/jobs_mobile_view_compnents/select_language_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../../../../providers/app_settings_provider.dart';
import '../../../../../providers/industry_provider.dart';
import '../../../../../providers/job_posts_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../common_vieiws/all_search_bar_components/all_search_bar.dart';
import '../../../../common_vieiws/loading_page.dart';
import '../../../../old_common_views/select_industry_components/display_industries.dart';
import '../../../saved/choose_target_language copy.dart';
import '../../../saved/job_search_result_page.dart';

class JobsPageDesktop extends StatefulWidget {
  const JobsPageDesktop({Key? key}) : super(key: key);

  @override
  State<JobsPageDesktop> createState() => _JobsPageDesktopState();

}
class _JobsPageDesktopState extends State<JobsPageDesktop> {

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
                : Showcase(
                key: asp.selection,
                description: 'Use this section to Select Jobs by industry',
                targetShapeBorder: const CircleBorder(),
                overlayOpacity: 0.6,
                tooltipBackgroundColor: Color.fromRGBO(30, 117, 187, 1),
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