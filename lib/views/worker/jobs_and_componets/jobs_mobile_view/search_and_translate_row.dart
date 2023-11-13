import 'package:flutter/material.dart';

import '../../../../utils/styles/theme_colors.dart';
import 'job_mobile_choose_target_language.dart';
import 'job_mobile_search_bar.dart';

class SearchAndTranslateRow extends StatelessWidget {
  const SearchAndTranslateRow({super.key});

  @override
  Widget build(BuildContext context) {
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
      child: const Row(
        children: [
          JobMobileSearchBar(),
          JobsMobileChooseTargetLanguage(),
        ],
      ),
    );
  }
}
