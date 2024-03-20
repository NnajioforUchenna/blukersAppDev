import 'package:blukers/providers/app_versions_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcaseview.dart' show Showcase;

import '../../../../../../utils/styles/index.dart';

class SignInRow extends StatelessWidget {
  const SignInRow({super.key});

  @override
  Widget build(BuildContext context) {
    AppSettingsProvider asp = Provider.of<AppSettingsProvider>(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
          height: 50,
          width: 100,
          child: Image.asset('assets/images/blukers_logo.png'),
        ),
        const Spacer(),
        Showcase(
          key: asp.signInButton,
          description: 'Use this button to sign in to your account',
          
            overlayOpacity: 0.6,
            targetShapeBorder: const CircleBorder(),
            tooltipBackgroundColor: Color.fromRGBO(30, 117, 187, 1),
         
            descTextStyle: const TextStyle( 
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
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
              child: Text(
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
