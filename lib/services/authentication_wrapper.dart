import 'dart:core';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/job_posts_provider.dart';
import '../providers/user_provider_parts/user_provider.dart';
import '../views/common_vieiws/landing_page/landing_page.dart';
import '../views/company/workers_home/workers_home.dart';
import '../views/worker/jobs_home/Components/jobs_desktop_view/web_search_landing_page.dart';
import '../views/worker/jobs_home/jobs_home.dart';

class AuthenticationWrapper extends StatefulWidget {
  const AuthenticationWrapper({super.key});

  @override
  State<AuthenticationWrapper> createState() => _AuthenticationWrapperState();
}

class _AuthenticationWrapperState extends State<AuthenticationWrapper> {
  late UserProvider up;

  // Get the current URL
  String urlEx = Uri.base.toString();
  late Uri uri;

  @override
  void initState() {
    up = Provider.of<UserProvider>(context, listen: false);
    uri = Uri.parse(urlEx);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
      return up.appUser != null
          ? const Workers() //Workers()
          : const Jobs(); //Jobs(); //Jobs();
    } else {
      return const LandingPage(); // SplashScreen(); //LandingPage()
    }
  }
}
