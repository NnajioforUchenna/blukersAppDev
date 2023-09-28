import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AlternativeLogoWidget extends StatelessWidget {
  final String char;
  final double size;

  const AlternativeLogoWidget(
      {Key? key, required this.char, required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Ensure the provided string is a single character
    assert(char.length == 1, 'Provide only a single character');

    // Generate a random color
    final random = Random();
    Color getRandomColor() => Color.fromRGBO(
          random.nextInt(256),
          random.nextInt(256),
          random.nextInt(256),
          1,
        );

    return Container(
      width: size, // Adjust as needed
      height: size, // Adjust as needed
      decoration: BoxDecoration(
        color: getRandomColor(),
        borderRadius: BorderRadius.circular(10.0),
      ),
      alignment: Alignment.center,
      child: Text(
        char.toUpperCase(),
        style: GoogleFonts.montserrat(
          fontSize: 35 * (size / 50.0),
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
    );
  }
}
