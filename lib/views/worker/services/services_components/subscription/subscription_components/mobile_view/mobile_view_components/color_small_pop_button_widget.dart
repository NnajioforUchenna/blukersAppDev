import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ColorSmallPopButtonWidget extends StatelessWidget {
  final Color color;
  const ColorSmallPopButtonWidget({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Material(
        elevation: 4.0, // Set the elevation here
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
              16.0), // Half of the width/height to make it a perfect circle
        ),
        child: Container(
          width: 32, // Adjust as needed
          height: 32, // Adjust as needed
          decoration: const BoxDecoration(
            color: Colors.white, // Adjust as needed
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              'X',
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w700, // Make it bold
                fontSize: 16, // Adjust the size
                color: color, // Set the color
              ),
            ),
          ),
        ),
      ),
    );
  }
}
