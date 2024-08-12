import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TopLeftText extends StatelessWidget {
  final String title;
  final String subtitle;
  const TopLeftText({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 100,
      left: 40,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.35,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              title.toUpperCase(),
              textAlign: TextAlign.end,
              style: GoogleFonts.montserrat(
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                  color: Colors.white),
            ),
            Text(
              subtitle.toUpperCase(),
              textAlign: TextAlign.end,
              style: GoogleFonts.montserrat(
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                  color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
