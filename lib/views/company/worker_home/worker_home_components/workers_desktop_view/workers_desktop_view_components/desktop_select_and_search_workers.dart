import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../../../../../providers/app_settings_provider.dart';
import '../../../../../../providers/industry_provider.dart';
import '../../../../../common_vieiws/loading_page.dart';
import '../../../../../old_common_views/select_industry_components/display_industries.dart';
import '../../../../../worker/jobs_home/job_home_components/jobs_desktop_view/jobs_desktop_view_components/select_desktop_language_dialog.dart';
import '../../../../search_workers/worker_search_bar_components/worker_all_search_bar.dart';

class DesktopSelectAndSearchWorkers extends StatefulWidget {
  const DesktopSelectAndSearchWorkers({super.key});

  @override
  State<DesktopSelectAndSearchWorkers> createState() =>
      _DesktopSelectAndSearchWorkersState();
}

class _DesktopSelectAndSearchWorkersState
    extends State<DesktopSelectAndSearchWorkers> {
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
    asp = Provider.of<AppSettingsProvider>(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          const WorkerAllSearchBar(),
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
            firstChild: const LoadingPage(),
            secondChild: Showcase(
                key: asp.selection,
                description: 'Use this section to Select Jobs by industry',
                targetShapeBorder: const CircleBorder(),
                overlayOpacity: 0.6,
                tooltipBackgroundColor: const Color.fromRGBO(30, 117, 187, 1),
                descTextStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                child: const DisplayIndustries()),
            crossFadeState: ip.industries.isEmpty
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
            duration: const Duration(milliseconds: 500),
          ),
        ],
      ),
    );
  }
}
