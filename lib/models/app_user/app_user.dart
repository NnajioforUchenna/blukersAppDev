import 'package:blukers/models/app_user/components/registration_details.dart';
import 'package:blukers/models/userJourney.dart';

import '../../data_providers/user_data_provider.dart';
import '../address.dart';
import '../company.dart';
import '../job_application_tracker.dart';
import '../payment_model/paid_order.dart';
import '../payment_model/subscription_model.dart';
import 'components/worker_records.dart';
import 'components/worker_resume_details.dart';

class AppUser {
  // User Information
  String uid;
  String email;
  String? language;
  String? displayName;
  String? phoneNumber;
  String? photoUrl;
  bool? isEmailVerified;

  // Tracking Registration Form
  RegistrationDetails? registrationDetails;

  // Tracking Worker Profile form
  WorkerResumeDetails? workerResumeDetails;
  WorkerRecords? workerRecords;

  // Tracking Company Profile form
  Company? company;

  Address? address;

  // Device Token for Push Notification
  List<String>? tokens = [];

  String? deviceTokenU;

  // Navigation Controls
  String? userRole;
  int? workerTimelineStep = 0;
  int? companyTimelineStep = 0;

  // Keeping record of time
  int createdAt = 0;
  int modifiedAt = 0;

  // Variables for Tracking Payments
  bool isSubscriptionActive = false;
  SubscriptionPlan? activeSubscription;
  SubscriptionPlan? deferredSubscription;
  Map<String, PaidOrder> listActiveOrders = {};

  // Tracking Applied Jobs
  JobApplicationTracker? jobApplicationTracker;

  // Deleting Account Parameters
  String deleteAccountReason = '';
  String whereYouReside = '';

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
    this.registrationDetails,
    this.workerResumeDetails,
    this.workerRecords,
    this.company,
    this.address,
    this.deviceTokenU,
    this.tokens,
    this.userRole,
    this.workerTimelineStep,
    this.companyTimelineStep,
    this.activeSubscription,
    this.deferredSubscription,
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
    if (registrationDetails != null) {
      data['registrationDetails'] = registrationDetails!.toMap();
    }
    if (workerResumeDetails != null) {
      data['workerResumeDetails'] = workerResumeDetails!.toMap();
    }
    if (workerRecords != null) data['workerRecords'] = workerRecords!.toMap();
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
    if (userJourney != null) data['userJourney'] = userJourney?.toMap();
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
      registrationDetails: (map['registrationDetails'] != null &&
              map['registrationDetails'] is Map<String, dynamic>)
          ? RegistrationDetails.fromMap(map['registrationDetails'])
          : null,
      userRole: map['userRole'] as String?,
      workerTimelineStep: map['workerTimelineStep'] as int?,
      companyTimelineStep: map['companyTimelineStep'] as int?,
      workerResumeDetails: (map['workerResumeDetails'] != null &&
              map['workerResumeDetails'] is Map<String, dynamic>)
          ? WorkerResumeDetails.fromMap(map['workerResumeDetails'])
          : null,
      workerRecords: (map['workerRecords'] != null &&
              map['workerRecords'] is Map<String, dynamic>)
          ? WorkerRecords.fromMap(map['workerRecords'])
          : null,
      company:
          (map['company'] != null && map['company'] is Map<String, dynamic>)
              ? Company.fromMap(map['company'])
              : null,
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
          ? List<String>.from(map['tokens'].map((x) => x as String))
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
    } else if (workerResumeDetails != null) {
      return '${workerResumeDetails!.firstName} ${workerResumeDetails!.lastName}';
    } else if (company != null) {
      return company!.name;
    } else {
      return "Display Name";
    }
  }
}
