import 'package:bulkers/models/industry.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bulkers/utils/styles/index.dart';

import 'industry_body_panel.dart';
import 'industry_head_panel.dart';

class DisplayIndustry extends StatelessWidget {
  final Industry industry;
  const DisplayIndustry({super.key, required this.industry});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: IndustryHeadPanel(industry: industry),
      backgroundColor: Colors.grey.shade100,
      collapsedBackgroundColor: Colors.white,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text("Select a Job Position",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: ThemeColors.secondaryThemeColor,
              )
            ),
        ),
        IndustryBodyPanel(jobs: industry.jobs),
      ],
    );
  }
}
