import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../../../providers/app_settings_provider.dart';
import '../../../../utils/styles/theme_colors.dart';

class CompanySignInRow extends StatelessWidget {
  const CompanySignInRow({super.key});

  @override
  Widget build(BuildContext context) {
    AppSettingsProvider asp = Provider.of<AppSettingsProvider>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          height: 50,
          width: 100,
          child: Image.asset('assets/images/blukers_logo.png'),
        ),
        Showcase(
          key: asp.signInButton,
          description: 'Use this button to sign in to your account',
          overlayOpacity: 0.6,
          targetShapeBorder: const CircleBorder(),
          tooltipBackgroundColor: const Color.fromRGBO(30, 117, 187, 1),
          descTextStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          child: SizedBox(
            height: 20,
            width: 80,
            child: ElevatedButton(
              onPressed: () {
                context.go('/login');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ThemeColors.primaryThemeColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: AutoSizeText(
                'Sign in',
                style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
