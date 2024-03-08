import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../providers/user_provider_parts/user_provider.dart';
import '../../../utils/styles/index.dart';
import '../policy_terms/privacy_policy_terms_and_conditions.dart';
import 'landing_page_components/option_box.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider up = Provider.of<UserProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 0.15.sh),
            SizedBox(
              // height: 0.4.sh, // Responsive height
              width: 0.6.sw,
              child: Image.asset(
                'assets/images/blukers_logo.png',
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 0.015.sh), // Responsive height
            Text(
              AppLocalizations.of(context)!.dreamBuildConnect,
              textAlign: TextAlign.center,
              style: ThemeTextStyles.landingPageSubtitleThemeTextStyle.copyWith(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold), // Responsive font size
            ),
            // Transform.translate(
            //   offset: Offset(0, -60.w), // Responsive width
            //   child: Text(
            //     AppLocalizations.of(context)!.dreamBuildConnect,
            //     textAlign: TextAlign.center,
            //     style: ThemeTextStyles.landingPageSubtitleThemeTextStyle
            //         .copyWith(fontSize: 18.sp), // Responsive font size
            //   ),
            // ),
            const SizedBox(height: 120),
            Padding(
              padding: EdgeInsets.all(16.w), // Responsive width
              child: Text(
                AppLocalizations.of(context)!.whatDoYouIdentifyAs,
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                  color: const Color(0xFFf06523),
                  fontWeight: FontWeight.w600,
                  fontSize: 20.sp, // Responsive font size
                ),
                // Responsive font size
              ),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OptionBox(
                  imgSrc: 'assets/images/worker_icon.png',
                  title: AppLocalizations.of(context)!.iAmA.toUpperCase(),
                  color: const Color(0xFF1c75bb),
                  subtitle: AppLocalizations.of(context)!.worker.toUpperCase(),
                  thirdLine: AppLocalizations.of(context)!
                      .lookingForJobs
                      .toUpperCase(),
                  onTap: () {
                    up.userRole = "worker";
                    context.go('/jobs');
                  },
                ),
                SizedBox(width: 20.w), // Responsive width
                OptionBox(
                  imgSrc: 'assets/images/company_icon.png',
                  title: AppLocalizations.of(context)!.iAmA2.toUpperCase(),
                  color: const Color(0xFFf06523),
                  subtitle: AppLocalizations.of(context)!.company.toUpperCase(),
                  thirdLine: AppLocalizations.of(context)!
                      .lookingForWorkers
                      .toUpperCase(),
                  onTap: () {
                    up.userRole = "company";
                    context.go('/workers');
                  },
                ),
              ],
            ),
            SizedBox(height: 0.02.sh), // Responsive height
            if (up.appUser == null)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildAuthButton(
                    context,
                    () => context.go('/login'),
                    AppLocalizations.of(context)!.signIn,
                  ),
                  Text(
                    AppLocalizations.of(context)!.or,
                    style: const TextStyle(
                      color: ThemeColors.grey2ThemeColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  buildAuthButton(
                    context,
                    () => context.go('/register'),
                    AppLocalizations.of(context)!.register,
                  ),
                ],
              ),
            if (!kIsWeb && up.appUser != null) SizedBox(height: 0.05.sh),
            if (!kIsWeb) const PrivacyPolicyTermsAndConditions(),
          ],
        ),
      ),
    );
  }

  Widget buildAuthButton(BuildContext context, onTap, text) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        padding: const EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              text,
              style: const TextStyle(
                color: ThemeColors.blukersBlueThemeColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
