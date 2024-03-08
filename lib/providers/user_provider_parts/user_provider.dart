// import 'dart:io';

import 'dart:io';

import 'package:blukers/data_providers/user_data_provider.dart';
import 'package:blukers/models/job_post.dart';
import 'package:blukers/models/jobs_perference.dart';
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

import '../../common_files/constants.dart';
import '../../data_providers/app_user_stream_service.dart';
import '../../data_providers/job_posts_data_provider.dart';
import '../../data_providers/worker_data_provider.dart';
import '../../models/app_user.dart';
import '../../models/company.dart';
import '../../models/reference_form.dart';
import '../../models/work_experience.dart';
import '../../models/worker.dart';
import '../../views/old_common_views/display_job_post_eligibility_dialog.dart';
import '../../views/old_common_views/job_timeline/display_job_timeline_dialog.dart';

part 'authentication_authorization.dart';
part 'creating_user_profile.dart';
part 'updating_profile_functions.dart';
part 'user_job_posts_functions.dart';
part 'user_navigation_functions.dart';

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

  // Variable holder for reference form
  List<Map<String, dynamic>> references = [{}, {}];

  List<Map<String, dynamic>> getReferences() {
    if (appUser == null || appUser!.worker == null) {
      return [{}, {}];
    }
    references = appUser!.worker!.references.map((e) => e.toMap()).toList();
    return references;
  }

  void setReferences(List<Map<String, dynamic>> references) {
    appUser!.worker!.references = [];
    appUser!.worker!.references = references
        .where((e) => e.isNotEmpty) // Filter out empty maps
        .map((e) => ReferenceForm.fromMap(e))
        .toList();
  }

  // Variable holder for WorkExperience Form
  List<Map<String, dynamic>> workExperiences = [{}, {}];

  List<Map<String, dynamic>> getWorkExperiences() {
    if (appUser == null ||
        appUser!.worker == null ||
        appUser!.worker!.workExperiences.isEmpty) {
      return [{}, {}];
    }
    workExperiences =
        appUser!.worker!.workExperiences.map((e) => e.toMap()).toList();
    return workExperiences;
  }

  void setWorkExperiences(List<Map<String, dynamic>> newWorkExperiences) {
    appUser!.worker!.workExperiences = [];
    appUser!.worker!.workExperiences = newWorkExperiences
        .where((e) => e.isNotEmpty) // Filter out empty maps
        .map((e) => WorkExperience.fromMap(e))
        .toList();
  }

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
    appUser?.worker?.appliedJobPostIds.add(jobPost.jobPostId);
    notifyListeners();
    // Persist data to database
    UserDataProvider.updateWorkerAppliedJobPostIds(
        appUser!.worker!.appliedJobPostIds, appUser!.uid);
    // update JobPost Records
    JobPostsDataProvider.updateJobPostAppliedWorkerIds(
        jobPost.jobPostId, appUser!.uid);
  }

  String whichMembership() {
    if (appUser == null || appUser?.activeSubscription == null) {
      return "basic";
    }
    return appUser!.activeSubscription!.subscriptionId;
  }

  String getButton(String subscriptionId) {
    return getButtonAction(whichMembership(), subscriptionId);
  }

  String getButtonAction(String state, String subscriptionId) {
    Map<String, Map<String, String>> actions = {
      'basic': {
        'basic': 'Active',
        'blukers_workers_premium': 'Purchase',
        'blukers_workers_premium_plus': 'Purchase'
      },
      'blukers_workers_premium': {
        'basic': 'Change Plan',
        'blukers_workers_premium': 'Active',
        'blukers_workers_premium_plus': 'Upgrade'
      },
      'blukers_workers_premium_plus': {
        'basic': 'Change Plan',
        'blukers_workers_premium': 'Change Plan',
        'blukers_workers_premium_plus': 'Active'
      }
    };

    if (actions.containsKey(state) &&
        actions[state]!.containsKey(subscriptionId)) {
      return actions[state]![subscriptionId]!;
    } else {
      return 'purchase';
    }
  }

  void updatingInformation(Future<void> Function() updateFunction) {
    EasyLoading.show(
      status: 'Updating Information...',
      maskType: EasyLoadingMaskType.black,
    );

    updateFunction().then((_) {
      Future.delayed(const Duration(seconds: 2), () {
        EasyLoading.dismiss();
        notifyListeners();
      });
    });
  }

  void updateReferences() {
    setReferences(references);
    updatingInformation(() async {
      await UserDataProvider.updateWorkerReferences(
          appUser!.worker!.references, appUser!.uid);
    });
  }

  void addReference() {
    references.add({});
    notifyListeners();
  }

  void addWorkExperience() {
    workExperiences.add({});
    notifyListeners();
  }

  void updateWorkExperiences() {
    setWorkExperiences(workExperiences);
    updatingInformation(() async {
      await UserDataProvider.updateWorkerWorkExperiences(
          appUser!.worker!.workExperiences, appUser!.uid);
    });
  }

  void updateUserCountry(String country) {
    if (appUser == null || appUser!.worker == null) {
      return;
    }
    appUser!.whereYouReside = country;
    notifyListeners();
  }

  bool getWhereDoYouReside() {
    if (appUser == null || appUser!.worker == null) {
      return false;
    }
    return appUser!.whereYouReside.isNotEmpty;
  }

  String getWhyDeleteAccount() {
    if (appUser == null || appUser!.worker == null) {
      return "";
    }
    return appUser!.deleteAccountReason;
  }

  void setWhyDeleteAccount(String selected) {
    if (appUser == null || appUser!.worker == null) {
      return;
    }
    appUser!.deleteAccountReason = selected;
    notifyListeners();
  }

  void updateJobsPreference(
      List<String> selectedIndustries, Map<String, List<String>> selectedJobs) {
    if (appUser != null) {
      JobsPreference jobsPreference = JobsPreference(
        industryIds: selectedIndustries,
        jobIds: selectedJobs,
      );
      appUser?.jobsPreference = jobsPreference;
    }
  }

  void updateSelection() {
    if (appUser != null) {
      UserDataProvider.updateJobsPreference(appUser!);
    }
  }
}
