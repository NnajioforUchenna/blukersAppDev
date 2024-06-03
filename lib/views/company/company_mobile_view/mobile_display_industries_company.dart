import 'package:blukers/views/worker/worker_home/worker_home_components/jobs_mobile_view/jobs_mobile_view_compnents/mobile_industry_headpanel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../../../providers/industry_provider.dart';
import '../../../../../../utils/styles/index.dart';
class CompanyMobileDisplayIndustries extends StatelessWidget {
  const CompanyMobileDisplayIndustries({super.key});

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
                child: MobileIndustryHeadPanel(industry: industry),
              );
            }).toList(),
          ),
          const SizedBox(height: 60),
        ],
      ),
    );
  }
}
