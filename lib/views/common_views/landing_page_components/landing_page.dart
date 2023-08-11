import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../providers/user_provider.dart';
import '../../../utils/styles/index.dart';
import 'option_box.dart';

import 'package:bulkers/views/auth/common_widget/label_button.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    UserProvider up = Provider.of<UserProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // First and Second sections combined: Logo/Image and Slogan
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width * 0.8,
              child: Image.asset(
                'assets/images/looking_for_you.png',
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            Transform.translate(
              offset: const Offset(0, -60),
              child: Text(
                AppLocalizations.of(context)!.dreamBuildConnect,
                textAlign: TextAlign.center,
                style: ThemeTextStyles.landingPageSubtitleThemeTextStyle,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            // Third section: Question to the user
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                AppLocalizations.of(context)!.whatAreYouLookingFor,
                textAlign: TextAlign.center,
                style: ThemeTextStyles.landingPageQuestionThemeTextStyle,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            // Fourth section: Two boxes
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // First box
                OptionBox(
                    imgSrc: 'assets/images/worker_icon.png',
                    title: AppLocalizations.of(context)!.aJob,
                    onTap: () {
                      up.userRole = "worker";
                      Navigator.pushNamed(context, '/jobs');
                    }),
                // Space between boxes
                const SizedBox(width: 20),
                // Second box
                OptionBox(
                  imgSrc: 'assets/images/company_icon.png',
                  title: AppLocalizations.of(context)!.workers,
                  onTap: () {
                    up.userRole = "company";
                    Navigator.pushNamed(context, '/workers');
                  },
                ),
              ],
            ),
            SizedBox(height: height * .01),
            if (up.appUser == null)
              LabelButton(
                onTap: () {
                  Navigator.pushNamed(context, "/login");
                },
                title: "Already Have An Account?",
                subTitle: "Sign In",
              ),
          ],
        ),
      ),
    );
  }
}
