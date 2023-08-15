import 'package:bulkers/views/auth/common_widget/label_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../providers/user_provider.dart';
import '../../../utils/styles/index.dart';
import 'option_box.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider up = Provider.of<UserProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 0.4.sh, // Responsive height
              width: 0.8.sw, // Responsive width
              child: Image.asset(
                'assets/images/looking_for_you.png',
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 0.03.sh), // Responsive height
            Transform.translate(
              offset: Offset(0, -60.w), // Responsive width
              child: Text(
                AppLocalizations.of(context)!.dreamBuildConnect,
                textAlign: TextAlign.center,
                style: ThemeTextStyles.landingPageSubtitleThemeTextStyle
                    .copyWith(fontSize: 16.sp), // Responsive font size
              ),
            ),
            const SizedBox(height: 25),
            Padding(
              padding: EdgeInsets.all(16.w), // Responsive width
              child: Text(
                AppLocalizations.of(context)!.whatAreYouLookingFor,
                textAlign: TextAlign.center,
                style: ThemeTextStyles.landingPageQuestionThemeTextStyle
                    .copyWith(fontSize: 18.sp), // Responsive font size
              ),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OptionBox(
                  imgSrc: 'assets/images/worker_icon.png',
                  title: AppLocalizations.of(context)!.aJob,
                  onTap: () {
                    up.userRole = "worker";
                    Navigator.pushNamed(context, '/jobs');
                  },
                ),
                SizedBox(width: 20.w), // Responsive width
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
            SizedBox(height: 0.01.sh), // Responsive height
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
