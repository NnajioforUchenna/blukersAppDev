import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/app_versions_provider.dart';
import '../providers/job_posts_provider.dart';
import '../providers/user_provider.dart';
import '../views/auth/registration_process.dart';
import '../views/common_views/splash_screen/splash_screen_main.dart';
import '../views/company/workers.dart';
import '../views/worker/create_worker_profile_component/create_worker_profile.dart';
import '../views/worker/jobs.dart';
import '../views/worker/web_jobs_landing_page/web_search_landing_page.dart';

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider up = Provider.of<UserProvider>(context);
    AppVersionsProvider avp = Provider.of<AppVersionsProvider>(context);

    if (!kIsWeb) {
      avp.checkForUpdate(context);
    }

    // Get the current URL
    String urlEx = Uri.base.toString();
    Uri uri = Uri.parse(urlEx);

    if (urlEx.contains('/register')) {
      return const RegistrationProcess();
    }

    if (urlEx.contains('/createWorkerProfile')) {
      return CreateWorkerProfile();
    }

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
          ? const Workers() //Workers()
          : const Jobs(); //Jobs();
    } else {
      return SplashScreen(); //LandingPage() SplashScreen()
    }
  }
}
