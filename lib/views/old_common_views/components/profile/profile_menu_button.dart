import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unicons/unicons.dart';

import '../../../../utils/styles/theme_colors.dart';

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

class DesktopMenuButton extends StatelessWidget {
  const DesktopMenuButton(
      {super.key,
      required this.child,
      required this.isSelected,
      this.selectedBorderColor = ThemeColors.primaryThemeColor,
      required this.onPressed});
  final Widget child;
  final bool isSelected;
  final Color selectedBorderColor;

  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            boxShadow: isSelected
                ? [
                    const BoxShadow(
                      color: Color(0x0D000000),
                      offset: Offset(0, 4),
                      blurRadius: 9.2,
                      spreadRadius: 9,
                    ),
                  ]
                : null,
            border: isSelected
                ? Border(
                    left: BorderSide(color: selectedBorderColor, width: 5.1))
                : null,
            color: isSelected ? Colors.white : const Color(0xFFF9F9FA)),
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 22),
        child: child,
      ),
    );
  }
}

class UpdateUserInfoDialog extends StatelessWidget {
  const UpdateUserInfoDialog({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      insetPadding:
          const EdgeInsets.only(left: 16, right: 16, top: 26, bottom: 80),
      child: child,
    );
  }
}
