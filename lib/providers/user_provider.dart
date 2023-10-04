// import 'dart:io';

import 'dart:io';

import 'package:blukers/data_providers/user_data_provider.dart';
import 'package:blukers/models/job_post.dart';
import 'package:blukers/providers/chat_provider.dart';
import 'package:blukers/services/notification_service.dart';
import 'package:blukers/services/stripe_data.dart';
import 'package:blukers/services/user_shared_preferences_services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../common_files/constants.dart';
import '../data_providers/app_user_stream_service.dart';
import '../data_providers/job_posts_data_provider.dart';
import '../models/address.dart';
import '../models/app_user.dart';
import '../models/company.dart';
import '../models/worker.dart';
import '../views/common_views/display_job_post_eligibility_dialog.dart';
import '../views/common_views/job_timeline/display_job_timeline_dialog.dart';
import '../views/membership/show_subscription_dialog.dart';

part "user_provider_parts/authentication_authorization.dart";
part "user_provider_parts/creating_user_profile.dart";
part "user_provider_parts/user_job_posts_functions.dart";
part "user_provider_parts/user_navigation_functions.dart";

class UserProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? _user;
  User? get user => _user;

  AppUser? _appUser;
  AppUser? get appUser => _appUser;
  late StreamService streamService;

  // Language Variables
  String language = "en";
  String get userLanguage {
    if (_appUser != null && _appUser!.language != null) {
      return _appUser!.language ?? language;
    } else {
      return language;
    }
  }

  // Navigation Variables
  String? userRole;
  int companyTimelineStep = 0;
  int workerTimelineStep = 0;

  int registerCurrentPageIndex = 0;
  int currentPageIndex = 0;

  UserProvider() {
    _auth.authStateChanges().listen((User? user) {
      _user = user;
      if (user != null) {
        initializeAppUser(user.uid);
      }
      notifyListeners();
    });
  }

  void initializeAppUser(String uid) {
    streamService = StreamService(uid);
    streamService.appUser.listen((updatedAppUser) {
      if (updatedAppUser == null) {
        return;
      }
      _appUser = updatedAppUser;
      updateNavigationVariables();
      notifyListeners();
    });
  }

  Future<bool> checkIfSubscribed() async {
    StripeData stripeData = await fetchStripeData();
    Stream<SubscriptionStatus> subscriptionStatusStream =
        checkSubscriptionStatus(appUser!.uid, stripeData);
    SubscriptionStatus subscriptionStatus =
        await subscriptionStatusStream.first;
    return subscriptionStatus.subIsActive;
  }

  void applyForJobPost(JobPost jobPost) {
    // print(jobPost.toString());
    // Update UI interFace
    appUser?.worker?.appliedJobPostIds?.add(jobPost!.jobPostId!);
    notifyListeners();
    // Persist data to database
    UserDataProvider.updateWorkerAppliedJobPostIds(
        appUser!.worker!.appliedJobPostIds!, appUser!.uid);
    // update JobPost Records
    JobPostsDataProvider.updateJobPostAppliedWorkerIds(
        jobPost!.jobPostId!, appUser!.uid);
  }

  String whichMembership() {
    if (appUser == null || appUser?.activeSubscription == null) {
      return "basic";
    }
    return appUser!.activeSubscription!.subscriptionId;
  }
}
