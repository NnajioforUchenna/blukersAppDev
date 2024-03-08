import '../../../services/responsive.dart';
import '../../../utils/styles/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

import 'list_industries.dart';

class DisplayIndustries extends StatelessWidget {
  const DisplayIndustries({super.key});

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

          Container(
            width: (Responsive.isDesktop(context))
                ? MediaQuery.of(context).size.width * 0.6
                : MediaQuery.of(context).size.width * 0.8,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.transparent,
                style: BorderStyle.solid,
                // width: 2.0,
              ),
              // color: Color(0xFFF05A22),
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: const ListIndustries(),
          ),
          // Bottom Space
          const SizedBox(height: 60),
        ],
      ),
    );
  }
}
