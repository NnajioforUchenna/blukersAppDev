import 'package:blukers/models/userJourney.dart';

import '../data_providers/user_data_provider.dart';
import 'address.dart';
import 'company.dart';
import 'job_application_tracker.dart';
import 'jobs_perference.dart';
import 'payment_model/paid_order.dart';
import 'payment_model/subscription_model.dart';
import 'worker.dart';

class AppUser {
  String uid;
  String email;
  String? language;
  String? displayName;
  String? phoneNumber;
  String? photoUrl;
  bool? isEmailVerified;

  // for Tracking Registration Process
  bool? isLoginInformation;
  String? registeredAs;
  bool? isBasicInformation;
  bool? isContactInformation;
  bool? isRegistrationComplete;

  Worker? worker; // Added Worker parameter
  Company? company; // Added Company parameter
  Address? address;

  // Device Token for Push Notification
  List<String>? tokens = [];

  String? deviceTokenU;

  // navigation Controls
  String? userRole;
  int? workerTimelineStep = 0;
  int? companyTimelineStep = 0;

  // Keeping record of time
  int createdAt = 0;
  int modifiedAt = 0;

  // Varibles for Tracking Payments
  bool isSubscriptionActive = false;
  SubscriptionPlan? activeSubscription;
  SubscriptionPlan? deferredSubscription;
  Map<String, PaidOrder> listActiveOrders = {};

  // Tracking Applied Jobs
  JobApplicationTracker? jobApplicationTracker;

  // Deleting Account Parameters
  String deleteAccountReason = '';
  String whereYouReside = '';

  // Set Jobs Perferences
  JobsPreference? jobsPreference;

  // Tracking User Journey in the App
  UserJourney? userJourney;

  AppUser({
    required this.uid,
    required this.email,
    this.language,
    this.displayName,
    this.phoneNumber,
    this.photoUrl,
    this.isEmailVerified,
    this.isLoginInformation,
    this.registeredAs,
    this.isBasicInformation,
    this.isContactInformation,
    this.isRegistrationComplete,
    this.worker, // Added Worker parameter
    this.company, // Added Company parameter
    this.address,
    this.deviceTokenU,
    this.tokens,
    this.userRole,
    this.workerTimelineStep,
    this.companyTimelineStep,
    this.activeSubscription,
    this.deferredSubscription,
    this.jobsPreference,
    this.userJourney,
    this.isSubscriptionActive = false,
    this.listActiveOrders = const {},
  })  : createdAt = DateTime.now().millisecondsSinceEpoch,
        modifiedAt = DateTime.now().millisecondsSinceEpoch,
        jobApplicationTracker = JobApplicationTracker();

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {};
    data['uid'] = uid; // Assuming uid will always be non-null
    data['email'] = email;
    if (language != null) data['language'] = language;
    if (displayName != null) data['displayName'] = displayName;
    if (phoneNumber != null) data['phoneNumber'] = phoneNumber;
    if (photoUrl != null) data['photoUrl'] = photoUrl;
    if (isEmailVerified != null) data['isEmailVerified'] = isEmailVerified;
    if (isLoginInformation != null) {
      data['isLoginInformation'] = isLoginInformation;
    }
    if (registeredAs != null) data['registeredAs'] = registeredAs;
    if (isBasicInformation != null) {
      data['isBasicInformation'] = isBasicInformation;
    }
    if (isContactInformation != null) {
      data['isContactInformation'] = isContactInformation;
    }
    if (isRegistrationComplete != null) {
      data['isRegistrationComplete'] = isRegistrationComplete;
    }
    if (worker != null) data['worker'] = worker!.toMap();
    if (company != null) data['company'] = company!.toMap();
    if (address != null) data['address'] = address!.toMap();
    if (deviceTokenU != null) data['deviceTokenU'] = deviceTokenU;
    if (tokens != null) data['tokens'] = tokens;

    if (userRole != null) data['userRole'] = userRole;
    if (workerTimelineStep != null) {
      data['workerTimelineStep'] = workerTimelineStep;
    }
    if (companyTimelineStep != null) {
      data['companyTimelineStep'] = companyTimelineStep;
    }
    if (createdAt != 0) data['createdAt'] = createdAt;
    if (modifiedAt != 0) data['modifiedAt'] = modifiedAt;
    if (activeSubscription != null) {
      data['activeSubscription'] = activeSubscription?.toMap();
    }
    if (deferredSubscription != null) {
      data['deferredSubscription'] = deferredSubscription?.toMap();
    }
    data['isSubscriptionActive'] = isSubscriptionActive;
    if (listActiveOrders.isNotEmpty) {
      data['listActiveOrders'] =
          listActiveOrders.map((key, value) => MapEntry(key, value.toMap()));
    }

    if (jobApplicationTracker != null) {
      data['jobApplicationTracker'] = jobApplicationTracker?.toMap();
    }

    if (jobsPreference != null) {
      data['jobsPreference'] = jobsPreference?.toMap();
    }

    if (userJourney != null) {
      data['userJourney'] = userJourney?.toMap();
    }

    data['deleteAccountReason'] = deleteAccountReason;
    data['whereYouReside'] = whereYouReside;

    return data;
  }

  static AppUser fromMap(Map<String, dynamic> map) {
    AppUser user = AppUser(
      uid: map['uid'] ?? '',
      email: map['email'] ?? '',
      language: map['language'] as String?,
      displayName: map['displayName'] as String?,
      phoneNumber: map['phoneNumber'] as String?,
      photoUrl: map['photoUrl'] as String?,
      isEmailVerified: map['isEmailVerified'] as bool?,
      isLoginInformation: map['isLoginInformation'] as bool?,
      registeredAs: map['registeredAs'] as String?,
      isBasicInformation: map['isBasicInformation'] as bool?,
      isContactInformation: map['isContactInformation'] as bool?,
      isRegistrationComplete: map['isRegistrationComplete'] as bool?,
      userRole: map['userRole'] as String?,
      workerTimelineStep: map['workerTimelineStep'] as int?,
      companyTimelineStep: map['companyTimelineStep'] as int?,
      worker: (map['worker'] != null && map['worker'] is Map<String, dynamic>)
          ? Worker.fromMap(map['worker'])
          : null,
      // Convert Map to Worker object
      company:
          (map['company'] != null && map['company'] is Map<String, dynamic>)
              ? Company.fromMap(map['company'])
              : null,
      // Convert Map to Company object
      address:
          (map['address'] != null && map['address'] is Map<String, dynamic>)
              ? Address.fromMap(map['address'])
              : null,
      isSubscriptionActive: map['isSubscriptionActive'] ?? false,
      activeSubscription: map['activeSubscription'] != null
          ? SubscriptionPlan.fromMap(map['activeSubscription'])
          : null,
      deferredSubscription: map['deferredSubscription'] != null
          ? SubscriptionPlan.fromMap(map['deferredSubscription'])
          : null,
      deviceTokenU: map['deviceTokenU'] as String?,
      tokens: map['tokens'] != null
          ? List<String>.from(map['tokens'].map((x) => x))
          : [],
    );

    if (map['listActiveOrders'] != null) {
      Map<String, dynamic> ordersMap = map['listActiveOrders'];
      user.listActiveOrders = ordersMap
          .map((key, value) => MapEntry(key, PaidOrder.fromMap(value)));
    }

    if (map['jobApplicationTracker'] != null) {
      user.jobApplicationTracker =
          JobApplicationTracker.fromMap(map['jobApplicationTracker']);
    }

    if (map['jobsPreference'] != null) {
      user.jobsPreference = JobsPreference.fromMap(map['jobsPreference']);
    }

    if (map['userJourney'] != null) {
      user.userJourney = UserJourney.fromMap(map['userJourney']);
    }

    user.deleteAccountReason = map['deleteAccountReason'] ?? '';
    user.whereYouReside = map['whereYouReside'] ?? '';

    user.createdAt = map['createdAt'] ?? 0;
    user.modifiedAt = map['modifiedAt'] ?? 0;

    return user;
  }

  @override
  String toString() {
    return toMap().toString();
  }

  bool? checkIfEligible() {
    return jobApplicationTracker
        ?.checkIfEligible(activeSubscription?.subscriptionId ?? 'basic');
  }

  void updateNumOfJobsAppliedToday() {
    jobApplicationTracker?.keepRecordOfNumberOfJobPostApplied();
    // Persist data to database
    UserDataProvider.updateNumOfJobsAppliedToday(jobApplicationTracker, uid);
  }

  String get getDisplayName {
    if (displayName != null && displayName!.isNotEmpty) {
      return displayName!;
    } else if (worker != null) {
      return '${worker!.firstName} ${worker!.lastName}';
    } else if (company != null) {
      return company!.name;
    } else {
      return "Display Name";
    }
  }
}
