import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:unicons/unicons.dart';

import '../../../utils/styles/theme_colors.dart';
import '../../../services/make_responsive_web.dart';

class PleaseCreateCompanyProfile extends StatelessWidget {
  const PleaseCreateCompanyProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFEF7FF),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Image.asset(
                'assets/images/pleaseCreateProfile.png',
                fit: BoxFit.cover, // Ensure the image covers its container while preserving its aspect ratio
                height: MediaQuery.of(context).size.height * 0.5, // Adjust height as needed
              ),
            ),
            const SizedBox(width: 20), // Space between image and text
            Expanded(
              child: PleaseCreateProfile(),
            ),
          ],
        ),
      ),
    );
  }
}

class PleaseCreateProfile extends StatelessWidget {
  const PleaseCreateProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Icon(
          UniconsLine.building,
          color: Colors.grey.shade400,
          size: 100,
        ),
        const SizedBox(height: 10.0),
        RichText(
          textAlign: TextAlign.start,
          text: TextSpan(
            style: const TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: ThemeColors.grey1ThemeColor,
            ),
            children: <TextSpan>[
              TextSpan(text: '${AppLocalizations.of(context)!.please} '),
              TextSpan(
                text: AppLocalizations.of(context)!.createCompanyProfile,
                style: const TextStyle(color: ThemeColors.primaryThemeColor),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    // Navigate to create company profile page
                    context.go('/createCompanyProfile');
                  },
              ),
              const TextSpan(text: '\n'),
            ],
          ),
        ),
      ],
    );
  }
}
