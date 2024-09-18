import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GreyContainer extends StatelessWidget {
  final String child;
  const GreyContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: const Color.fromRGBO(243, 85, 7, 0.1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Text(
          child,
          style:
              GoogleFonts.montserrat(fontSize: 12, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
