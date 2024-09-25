import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unicons/unicons.dart';

class ProfileMenuButton extends StatelessWidget {
  final String text;
  final Function onPress;
  final Color textColor;
  final Widget? trailing;

  const ProfileMenuButton(
      {super.key,
      required this.text,
      required this.onPress,
      this.textColor = const Color(0xFF595959),
      this.trailing});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPress();
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF9F9F9),
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.25),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 2),
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
              trailing ??
                  const Icon(
                    UniconsLine.angle_right,
                    size: 30.0,
                    color: Color(0xFF595959),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
