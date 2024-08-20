import 'package:blukers/providers/app_settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../../../../../utils/styles/theme_colors.dart';
import '../../../../search_jobs/job_search_bar_components/job_mobile_search_bar.dart';
import 'job_mobile_choose_target_language.dart';

class SearchAndTranslateRow extends StatelessWidget {
  const SearchAndTranslateRow({super.key});

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
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Align items with space between them
        children: [
          Showcase(
            key: asp.searchBar,
            description: 'Use this search bar to search for jobs',
            overlayOpacity: 0.6,
            
            tooltipBackgroundColor: ThemeColors.primaryThemeColor,
            descTextStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            child: const JobMobileSearchBar(),
          ),
          Showcase(
            key: asp.translation,
            description: 'For selecting the target language of the job description',
            overlayOpacity: 0.6,
            tooltipBackgroundColor: ThemeColors.primaryThemeColor,
            descTextStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            child: const JobsMobileChooseTargetLanguage(),
          ),
        ],
      ),
    );
  }
}
