import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:unicons/unicons.dart';

import '../../../services/make_responsive_web.dart';
import '../../../utils/styles/theme_colors.dart';

class PleaseCreateWorkerProfile extends StatelessWidget {
  const PleaseCreateWorkerProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return const MakeResponsiveWeb(
      image: AssetImage('assets/images/pleaseCreateProfile.png'),
      child: PleaseCreateProfile(),
    );
  }
}

class PleaseCreateProfile extends StatelessWidget {
  const PleaseCreateProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              UniconsLine.building,
              color: Colors.grey.shade400,
              size: 100,
            ),
            const SizedBox(height: 10.0),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: const TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: ThemeColors.grey1ThemeColor,
                ),
                children: <TextSpan>[
                  // const TextSpan(text: 'Please '),
                  TextSpan(text: '${AppLocalizations.of(context)!.please} '),
                  TextSpan(
                    // text: AppLocalizations.of(context)!.createCompanyProfile,
                    text: 'Create Worker Profile',
                    style:
                        const TextStyle(color: ThemeColors.primaryThemeColor),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        // Navigate to create company profile page
                        context.go('/createWorkerProfile');
                      },
                  ),
                  const TextSpan(text: '\n'),
                  // TextSpan(
                  //   text: AppLocalizations.of(context)!.toAccessCompanyFeatures,
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
