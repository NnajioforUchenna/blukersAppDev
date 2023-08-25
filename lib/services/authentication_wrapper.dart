import 'dart:core';

import 'package:flutter/foundation.dart';
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

class AuthenticationWrapper extends StatefulWidget {
  const AuthenticationWrapper({super.key});

  @override
  State<AuthenticationWrapper> createState() => _AuthenticationWrapperState();
}

class _AuthenticationWrapperState extends State<AuthenticationWrapper> {
  bool gettingVersion = true;
  bool shouldUpdate = false;
  //call updater is required because we are not calling {avp.shouldUpdateApp()} function in initState
  //this function is called in build and build gets updated very frequently but we need to call this fuction only once
  //else it will stuck in a loop
  bool callUpdater = true;
  @override
  Widget build(BuildContext context) {
    UserProvider up = Provider.of<UserProvider>(context);
    AppVersionsProvider avp = Provider.of<AppVersionsProvider>(context);
    if (callUpdater && !kIsWeb) {
      avp.shouldUpdateApp().then((value) {
        print("update: " + value!.toString());

        showDialog(
          context: context,
          barrierDismissible:
              false, // Dialog cannot be dismissed by tapping outside
          builder: (BuildContext context) {
            return UpdateAppDialog(url: avp.androidUrl ?? "",);
          },
        );
        setState(() {
          shouldUpdate = value;
          gettingVersion = false;
        });
      });
      setState(() {
        callUpdater = false;
      });
    }
   //while the controll is fetching the version and checking if update is required or not
    if (gettingVersion && !kIsWeb) {
      return const Scaffold(
        body: Center(
          child: Text("Checking App Version!"),
        ),
      );
    }
    //the control has fetched the version and update is required.
    //at this stage, an slert will be shown to user
    if (shouldUpdate && !kIsWeb) {
      return const Scaffold(
        body: Center(
          child: Text("Update required!"),
        ),
      );
    }
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
