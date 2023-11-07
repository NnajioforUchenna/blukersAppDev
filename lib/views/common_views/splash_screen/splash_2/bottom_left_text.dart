import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../utils/styles/theme_colors.dart';

class BottomLeftText extends StatelessWidget {
  final String title;
  final String subtitle;
  const BottomLeftText(
      {super.key, required this.title, required this.subtitle});
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 40,
      left: 50,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.35,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              title.toUpperCase(),
              textAlign: TextAlign.end,
              style: GoogleFonts.montserrat(
                  fontSize: 23,
                  fontWeight: FontWeight.w600,
                  color: ThemeColors.secondaryThemeColor),
            ),
            Text(
              subtitle.toUpperCase(),
              textAlign: TextAlign.end,
              style: GoogleFonts.montserrat(
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                  color: ThemeColors.secondaryThemeColor),
            ),
          ],
        ),
      ),
    );
  }
}
