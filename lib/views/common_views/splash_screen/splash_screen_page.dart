import 'package:blukers/views/common_views/splash_screen/splash_screen_custom_shape.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../landing_page_components/landing_page.dart';

class SplashScreenPage extends StatelessWidget {
  final String workerTitle;
  final String workerSubtitle;
  final String companyTitle;
  final String companySubtitle;

  const SplashScreenPage({
    Key? key,
    required this.workerTitle,
    required this.workerSubtitle,
    required this.companyTitle,
    required this.companySubtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 20.h),
          Center(
            child: SplashScreenCustomShape(
              width: width > 370 ? 350 : width * 0.8,
              height: height > 650 ? 625 : height * 0.8,
              workerTitle: workerTitle,
              workerSubtitle: workerSubtitle,
              companyTitle: companyTitle,
              companySubtitle: companySubtitle,
            ),
          ),
          SizedBox(height: 30.h),
          // Add skip button
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const LandingPage()));
            },
            child: Text(
              AppLocalizations.of(context)!.skip,
              style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 16.sp,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ],
      ),
    );
  }
}