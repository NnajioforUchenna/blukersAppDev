import 'dart:core';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/job_posts_provider.dart';
import '../providers/user_provider.dart';
import '../providers/app_versions_provider.dart';
import '../views/common_views/splash_screen/splash_screen_main.dart';
import '../views/company/workers.dart';
import '../views/worker/jobs.dart';
import '../views/worker/web_jobs_landing_page/web_search_landing_page.dart';

import 'package:blukers/views/common_views/components/update_app_dialog.dart';

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider up = Provider.of<UserProvider>(context);
    AppVersionsProvider avp = Provider.of<AppVersionsProvider>(context);

    // IF SHOULD UPDATE APP, DISPLAY ALERT, AND DO NOT LET USER NAVIGATE TO
    // OTHER SCREENS
    // You can make use of any of these files to achieve showing the alert:
    // avp.shouldUpdateApp()
    // /views/common_views/components/update_app_dialog.dart
    // UpdateAppDialog();

    // Get the current URL
    String urlEx = Uri.base.toString();
    Uri uri = Uri.parse(urlEx);

    // Check for the query parameters
    String? nameSearch = uri.queryParameters['nameSearch'];
    String? locationSearch = uri.queryParameters['locationSearch'];

    if (nameSearch != null || locationSearch != null) {
      up.userRole = 'worker';
      Provider.of<JobPostsProvider>(context, listen: false)
          .getJobsBySearchParameter(nameSearch ?? '', locationSearch ?? '');
      return WebSearchLandingPage();
    }

    if (up.user != null) {
      return up.appUser != null && up.appUser?.registeredAs == 'company'
          ? const Workers()
          : const Jobs();
    } else {
      return SplashScreen(); //LandingPage() SplashScreen()
    }
  }
}
