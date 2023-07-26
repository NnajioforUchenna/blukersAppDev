import 'package:bulkers/models/industry.dart';
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
      children: [
        IndustryBodyPanel(jobs: industry.jobs),
      ],
    );
  }
}
