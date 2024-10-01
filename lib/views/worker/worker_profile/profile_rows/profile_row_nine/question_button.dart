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
    return InkWell(
      onTap: () {
        onPress();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFD0D0D5)),
          color: Colors.white, // Background color of the container
          borderRadius: BorderRadius.circular(8.0), // Rounded corners
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.25), // Box shadow color
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 2), // Shadow position
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              text,
              style: GoogleFonts.montserrat(
                color: ThemeColors.black1ThemeColor,
                fontSize: Responsive.isMobile(context) ? 14.sp : 20,
                fontWeight: FontWeight.w500,
              ),
            ),
           Icon(
              UniconsLine.angle_right,
              size:  Responsive.isMobile(context) ?  25: 30.0,
              color: ThemeColors.black1ThemeColor,
            ),
          ],
        ),
      ),
    );
  }
}
