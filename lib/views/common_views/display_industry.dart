import 'package:bulkers/models/industry.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text("Please select the Job Type?",
              textAlign: TextAlign.center,
              style: GoogleFonts.ebGaramond(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.pink,
              )),
        ),
        IndustryBodyPanel(jobs: industry.jobs),
      ],
    );
  }
}
