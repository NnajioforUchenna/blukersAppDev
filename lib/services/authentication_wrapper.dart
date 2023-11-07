import 'dart:core';

import 'package:blukers/providers/payment_providers/payments_provider.dart';
import 'package:blukers/views/common_views/splash_screen/splash_screen_main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/app_versions_provider.dart';
import '../providers/job_posts_provider.dart';
import '../providers/user_provider_parts/user_provider.dart';
import '../views/company/workers.dart';
import '../views/worker/jobs_and_componets/jobs.dart';
import '../views/worker/web_jobs_landing_page/web_search_landing_page.dart';

class AuthenticationWrapper extends StatefulWidget {
  const AuthenticationWrapper({super.key});

  @override
  State<AuthenticationWrapper> createState() => _AuthenticationWrapperState();
}

class _AuthenticationWrapperState extends State<AuthenticationWrapper> {
  late UserProvider up;
  late AppVersionsProvider avp;
  late PaymentsProvider pp;

  // Get the current URL
  String urlEx = Uri.base.toString();
  late Uri uri;

  @override
  void initState() {
    up = Provider.of<UserProvider>(context, listen: false);
    avp = Provider.of<AppVersionsProvider>(context, listen: false);
    pp = Provider.of<PaymentsProvider>(context, listen: false);
    uri = Uri.parse(urlEx);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!kIsWeb) {
      avp.checkForUpdate(context);
    }

    // Check for the query parameters
    String? nameSearch = uri.queryParameters['nameSearch'];
    String? locationSearch = uri.queryParameters['locationSearch'];

    if (nameSearch != null || locationSearch != null) {
      up.userRole = 'worker';
      Provider.of<JobPostsProvider>(context, listen: false)
          .getJobsBySearchParameter(nameSearch ?? '', locationSearch ?? '');
      return const WebSearchLandingPage();
    }

    if (up.user != null) {
      return up.appUser != null && up.appUser?.registeredAs == 'company'
          ? const Workers() //Workers()
          : const Jobs(); //Jobs(); //Jobs();
    } else {
      return SplashScreen(); // SplashScreen(); //LandingPage()
    }
  }
}
