import 'package:blukers/models/payment_model/active_subscription.dart';
import 'package:blukers/models/payment_model/paid_order.dart';
import 'package:blukers/models/worker.dart';

import 'address.dart';
import 'company.dart';

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
  ActiveSubscription? activeSubscription;
  Map<String, PaidOrder> listActiveOrders = {};

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
    this.userRole,
    this.workerTimelineStep,
    this.companyTimelineStep,
    this.activeSubscription,
    this.isSubscriptionActive = false,
    this.listActiveOrders = const {},
  })  : createdAt = DateTime.now().millisecondsSinceEpoch,
        modifiedAt = DateTime.now().millisecondsSinceEpoch;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {};
    data['uid'] = uid; // Assuming uid will always be non-null
    if (email != null) data['email'] = email;
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
    if (userRole != null) data['userRole'] = userRole;
    if (workerTimelineStep != null)
      data['workerTimelineStep'] = workerTimelineStep;
    if (companyTimelineStep != null)
      data['companyTimelineStep'] = companyTimelineStep;
    if (createdAt != 0) data['createdAt'] = createdAt;
    if (modifiedAt != 0) data['modifiedAt'] = modifiedAt;
    if (activeSubscription != null) {
      data['activeSubscription'] = activeSubscription?.toMap();
    }
    data['isSubscriptionActive'] = isSubscriptionActive;
    if (listActiveOrders.isNotEmpty) {
      data['listActiveOrders'] =
          listActiveOrders.map((key, value) => MapEntry(key, value.toMap()));
    }

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
          : null, // Convert Map to Worker object
      company:
          (map['company'] != null && map['company'] is Map<String, dynamic>)
              ? Company.fromMap(map['company'])
              : null, // Convert Map to Company object
      address:
          (map['address'] != null && map['address'] is Map<String, dynamic>)
              ? Address.fromMap(map['address'])
              : null,
      isSubscriptionActive: map['isSubscriptionActive'] ?? false,
      activeSubscription: map['activeSubscription'] != null
          ? ActiveSubscription.fromMap(map['activeSubscription'])
          : null,
    );

    if (map['listActiveOrders'] != null) {
      Map<String, dynamic> ordersMap = map['listActiveOrders'];
      user.listActiveOrders = ordersMap
          .map((key, value) => MapEntry(key, PaidOrder.fromMap(value)));
    }

    user.createdAt = map['createdAt'] ?? 0;
    user.modifiedAt = map['modifiedAt'] ?? 0;

    return user;
  }

  @override
  String toString() {
    return toMap().toString();
  }
}
