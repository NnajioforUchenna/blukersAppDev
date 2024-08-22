import 'package:blukers/services/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unicons/unicons.dart';

import '../../../../../utils/styles/theme_colors.dart';

class QuestionButton extends StatelessWidget {
  String text;
  Function onPress;

  QuestionButton({
    super.key,
    required this.text,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPress();
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white, // Background color of the container
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
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                text,
                style: GoogleFonts.montserrat(
                  color: Colors.grey,
                  fontSize: Responsive.isMobile(context) ? 10.sp : 11,
                  fontWeight: FontWeight.w600,
                ),
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
