import 'package:blukers/utils/styles/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class AuthTextFieldWrapper extends StatelessWidget {
  final Widget child;
  final String label;
  const AuthTextFieldWrapper({super.key, required this.child, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.montserrat(
            color: ThemeColors.black1ThemeColor,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(
          height: 2,
        ),
        child
      ],
    );
  }
}
