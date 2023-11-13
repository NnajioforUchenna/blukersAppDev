import 'package:blukers/utils/styles/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

import 'mobile_list_industries.dart';

class MobileDisplayIndustries extends StatelessWidget {
  const MobileDisplayIndustries({super.key});

  @override
  Widget build(BuildContext context) {
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
          const MobileListIndustries(),
          const SizedBox(height: 60),
        ],
      ),
    );
  }
}
