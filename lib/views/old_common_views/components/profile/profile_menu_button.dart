import '../../../../utils/styles/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unicons/unicons.dart';

class ProfileMenuButton extends StatelessWidget {
  String text;
  Function onPress;
  Color textColor;

  ProfileMenuButton({
    super.key,
    required this.text,
    required this.onPress,
    this.textColor = ThemeColors.black1ThemeColor
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPress();
      },
      child: Container(
        // margin: const EdgeInsets.all(14.0),
        height: 65,
        margin: const EdgeInsets.symmetric(horizontal: 30),
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
                  color: textColor,
                  fontSize: 14.0,
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
