import 'package:blukers/utils/styles/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TopRightText extends StatelessWidget {
  final String title;
  final String subtitle;
  const TopRightText({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 100,
      right: 50,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.35,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title.toUpperCase(),
              textAlign: TextAlign.start,
              style: GoogleFonts.montserrat(
                fontSize: 23,
                height: 0.9, // Reduced leading for tighter line spacing
                fontWeight: FontWeight.w600,
                color: ThemeColors.primaryThemeColor,
              ),
            ),
            const SizedBox(
                height:
                    4), // You can adjust this value to change the space between the title and subtitle
            Text(
              subtitle.toUpperCase(),
              textAlign: TextAlign.start,
              style: GoogleFonts.montserrat(
                fontSize: 30,
                height: 0.9, // Reduced leading for tighter line spacing
                fontWeight: FontWeight.w900,
                color: ThemeColors.primaryThemeColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
