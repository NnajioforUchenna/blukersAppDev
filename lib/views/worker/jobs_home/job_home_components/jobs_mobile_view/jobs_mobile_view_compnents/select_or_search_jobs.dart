import 'package:blukers/views/worker/jobs_home/job_home_components/jobs_mobile_view/jobs_mobile_view_compnents/search_and_translate_row.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../../../../../providers/app_settings_provider.dart';
import '../../../../../../providers/industry_provider.dart';
import '../../../../../../providers/job_posts_provider.dart';
import '../../../../../Modules/select_by_industry/select_by_industry.dart';
import '../../../../../common_vieiws/loading_page.dart';

class SelectOrSearchJobs extends StatefulWidget {
  const SelectOrSearchJobs({super.key});

  @override
  State<SelectOrSearchJobs> createState() => _SelectOrSearchJobsState();
}

class _SelectOrSearchJobsState extends State<SelectOrSearchJobs> {
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
        const SearchAndTranslateRow(),
        Expanded(
          child: AnimatedCrossFade(
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
                child: SelectByIndustry(
                  selectBy: 'Jobs',
                  getRecords: jp.getJobsBySelection,
                )),
            crossFadeState: ip.industries.isEmpty
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
            duration: const Duration(milliseconds: 500),
          ),
        ),
      ],
    );
  }
}
