import 'package:blukers/providers/app_settings_provider.dart';
import 'package:blukers/views/company/search_workers/worker_search_bar_components/worker_mobile_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../../../utils/styles/theme_colors.dart';
import '../../../worker/jobs_home/job_home_components/jobs_mobile_view/jobs_mobile_view_compnents/job_mobile_choose_target_language.dart';

class SearchAndTranslateRowCompany extends StatelessWidget {
  const SearchAndTranslateRowCompany({super.key});

  @override
  Widget build(BuildContext context) {
    AppSettingsProvider asp = Provider.of<AppSettingsProvider>(context);
    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      decoration: const BoxDecoration(
        color: ThemeColors.searchBarPrimaryThemeColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: Showcase(
                key: asp.searchBar,
                description: 'Use this search bar to search for jobs',
                overlayOpacity: 0.6,
                targetShapeBorder: const CircleBorder(),
                tooltipBackgroundColor: ThemeColors.primaryThemeColor,
                descTextStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                child: const WorkerMobileSearchBar()),
          ),
          Expanded(
            child: Showcase(
                key: asp.translation,
                description:
                    'For selecting the target language of the job description',
                overlayOpacity: 0.6,
                targetShapeBorder: const CircleBorder(),
                targetBorderRadius: const BorderRadius.all(
                  Radius.circular(10.0), // Example border radius
                ),
                tooltipBackgroundColor: ThemeColors.primaryThemeColor,
                descTextStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                child: const JobsMobileChooseTargetLanguage()),
          ),
        ],
      ),
    );
  }
}
