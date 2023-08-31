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
import '../views/membership/subscription_components/payment_failed_widget.dart';
import '../views/membership/subscription_components/payment_successful_widget.dart';
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

    // Go Straight to the Register page
    if (urlEx.contains('/register')) {
      return const RegistrationProcess();
    }

    // Go Straight to the create worker profile page
    if (urlEx.contains('/createWorkerProfile')) {
      return CreateWorkerProfile();
    }

    // Display the Failed Payment Page
    if (urlEx.contains('/paymentFailed')) {
      return PaymentFailedWidget();
    }

    // Display the Success Payment Page
    if (urlEx.contains('/paymentSuccess')) {
      return PaymentSuccessfulWidget();
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
          : Jobs(); //Jobs(); //Jobs();
    } else {
      return SplashScreen(); // SplashScreen(); //LandingPage() SplashScreen()
    }
  }
}
