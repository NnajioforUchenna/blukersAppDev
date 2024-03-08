import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BottomRightText extends StatelessWidget {
  final String title;
  final String subtitle;
  const BottomRightText(
      {super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 40,
      right: 40,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.35,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title.toUpperCase(),
              textAlign: TextAlign.start,
              style: GoogleFonts.montserrat(
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                  color: Colors.white),
            ),
            Text(
              subtitle.toUpperCase(),
              textAlign: TextAlign.start,
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
