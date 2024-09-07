import 'package:blukers/utils/styles/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SignInOptionsWidget extends StatelessWidget {
  const SignInOptionsWidget({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.label,
  });

  final String icon;
  final VoidCallback onPressed;
  final String label;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
              color: ThemeColors.black1ThemeColor.withOpacity(.3), width: .5),
        ),
        child: Row(
          children: [
            SvgPicture.asset(icon),
            const SizedBox(
              width: 24,
            ),
            Text(
              label,
              style: GoogleFonts.montserrat(
                color: ThemeColors.black1ThemeColor,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            )
          ],
        ),
      ),
    );
  }
}
