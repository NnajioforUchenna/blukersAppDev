import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StatusIndicatorWidget extends StatelessWidget {
  final String status;
  const StatusIndicatorWidget({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              "Processing".toUpperCase(),
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.grey[800],
              ),
            ),
          ),
        ),
        CustomProgressIndicator(),
      ],
    ));
  }
}

class CustomProgressIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Stack(
      alignment: Alignment.center,
      children: [
        // Background Indicator
        SizedBox(
          width: 140,
          height: 140,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
            value: 1, // Always full
            strokeWidth: 10.0,
          ),
        ),

        // Progress Indicator
        SizedBox(
          width: 140,
          height: 140,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
            backgroundColor: Colors.transparent,
            strokeWidth: 10.0,
          ),
        ),
      ],
    );
  }
}
