import 'package:blukers/models/industry.dart';
import 'package:blukers/utils/styles/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'industry_body_panel.dart';
import 'industry_head_panel.dart';

class DisplayIndustry extends StatelessWidget {
  final Industry industry;
  const DisplayIndustry({super.key, required this.industry});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: IndustryHeadPanel(industry: industry),
      backgroundColor: Colors.white,
      collapsedBackgroundColor: Colors.white,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            AppLocalizations.of(context)!.selectAJobPosition,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: ThemeColors.secondaryThemeColor,
            ),
          ),
        ),
        IndustryBodyPanel(jobs: industry.jobs.values.toList()),
      ],
    );
  }
}
