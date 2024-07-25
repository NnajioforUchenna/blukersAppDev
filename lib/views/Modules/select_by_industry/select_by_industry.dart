import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../providers/industry_provider.dart';
import '../../../utils/styles/theme_colors.dart';
import 'Components/industry_head_panel.dart';

class SelectByIndustry extends StatelessWidget {
  final String selectBy;
  final Function getRecords;
  const SelectByIndustry(
      {super.key, required this.selectBy, required this.getRecords});

  @override
  Widget build(BuildContext context) {
    IndustriesProvider ip = Provider.of<IndustriesProvider>(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 30.0),
            child: Text(AppLocalizations.of(context)!.selectAnIndustry,
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w700,
                  color: ThemeColors.secondaryThemeColor,
                )),
          ),
          Column(
            children: ip.industries.values.map((industry) {
              return Container(
                margin:
                    const EdgeInsets.only(bottom: 10.0, left: 30, right: 30),
                child: IndustryHeadPanel(
                  industry: industry,
                  getRecords: getRecords,
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 60),
        ],
      ),
    );
  }
}
