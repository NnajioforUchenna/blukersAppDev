import 'package:blukers/models/industry.dart';
import 'package:blukers/utils/styles/index.dart';
import 'package:flutter/material.dart';

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
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text("Select a Job Position",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: ThemeColors.secondaryThemeColor,
              )),
        ),
        IndustryBodyPanel(jobs: industry.jobs),
      ],
    );
  }
}
