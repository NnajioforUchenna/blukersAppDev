import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unicons/unicons.dart';

import '../../../../../../../../utils/styles/theme_colors.dart';

class ChangeSubscriptionButton extends StatelessWidget {
  final String title;
  final Color color;
  final Function onTap;

  const ChangeSubscriptionButton(
      {super.key,
      required this.title,
      required this.color,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        // margin: const EdgeInsets.all(14.0),
        margin: const EdgeInsets.symmetric(horizontal: 30),
        decoration: BoxDecoration(
          color: color, // Background color of the container
          borderRadius: BorderRadius.circular(10.0), // Rounded corners
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.25), // Box shadow color
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 2), // Shadow position
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                title,
                style: GoogleFonts.montserrat(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
              const Icon(
                UniconsLine.angle_right,
                size: 30.0,
                color: ThemeColors.grey2ThemeColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
