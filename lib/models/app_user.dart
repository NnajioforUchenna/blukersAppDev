import 'package:bulkers/models/worker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'address.dart';
import 'company.dart';

class AppUser {
  String uid;
  String? email;
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

  AppUser({
    required this.uid,
    this.email,
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
    this.createdAt = 0,
    this.modifiedAt = 0,
  });

  // New constructor for User.fromSignUp
  AppUser.fromSignUp({
    required this.uid,
    this.email,
    this.isLoginInformation = false,
    this.registeredAs,
    this.isBasicInformation = false,
    this.isContactInformation = false,
    this.isRegistrationComplete = false,
    this.language,
    this.displayName,
    this.phoneNumber,
    this.photoUrl,
    this.isEmailVerified,
    this.worker, // Added Worker parameter
    this.company, // Added Company parameter
    this.address,
    this.deviceTokenU,
    this.userRole,
    this.workerTimelineStep,
    this.companyTimelineStep,
    this.createdAt = 0,
    this.modifiedAt = 0,
  });

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

    return data;
  }

  factory AppUser.fromDocument(DocumentSnapshot<Map<String, dynamic>> doc) {
    Map<String, dynamic> map = doc.data()!;
    return AppUser(
      uid: map['uid'],
      email: map['email'],
      language: map['language'],
      displayName: map['displayName'],
      phoneNumber: map['phoneNumber'],
      photoUrl: map['photoUrl'],
      isEmailVerified: map['isEmailVerified'],
      isLoginInformation: map['isLoginInformation'],
      registeredAs: map['registeredAs'],
      isBasicInformation: map['isBasicInformation'],
      isContactInformation: map['isContactInformation'],
      isRegistrationComplete: map['isRegistrationComplete'],
      userRole: map['userRole'],
      workerTimelineStep: map['workerTimelineStep'],
      companyTimelineStep: map['companyTimelineStep'],
      worker: map['worker'] != null
          ? Worker.fromMap(map['worker'])
          : null, // Convert Map to Worker object
      company: map['company'] != null
          ? Company.fromMap(map['company'])
          : null, // Convert Map to Company object
      address: map['address'] != null
          ? Address.fromMap(map['address'])
          : null, // Convert Map to Address object
      createdAt: map['createdAt'] ?? 0,
      modifiedAt: map['modifiedAt'] ?? 0,
    );
  }

  static AppUser fromMap(Map<String, dynamic> map) {
    return AppUser(
      uid: map['uid'],
      email: map['email'],
      language: map['language'],
      displayName: map['displayName'],
      phoneNumber: map['phoneNumber'],
      photoUrl: map['photoUrl'],
      isEmailVerified: map['isEmailVerified'],
      isLoginInformation: map['isLoginInformation'],
      registeredAs: map['registeredAs'],
      isBasicInformation: map['isBasicInformation'],
      isContactInformation: map['isContactInformation'],
      isRegistrationComplete: map['isRegistrationComplete'],
      userRole: map['userRole'],
      workerTimelineStep: map['workerTimelineStep'],
      companyTimelineStep: map['companyTimelineStep'],
      worker: map['worker'] != null
          ? Worker.fromMap(map['worker'])
          : null, // Convert Map to Worker object
      company: map['company'] != null
          ? Company.fromMap(map['company'])
          : null, // Convert Map to Company object
      address: map['address'] != null ? Address.fromMap(map['address']) : null,
      createdAt: map['createdAt'] ?? 0,
      modifiedAt: map['modifiedAt'] ?? 0,
    );
  }

  @override
  String toString() {
    return toMap().toString();
  }

  // Convert AppUser object to Map<String, String>
  Map<String, String> toSp() {
    return {
      'uid': uid ?? "",
      'email': email ?? "",
      'language': language ?? "",
      'displayName': displayName ?? "",
      'photoUrl': photoUrl ?? "",
      'deviceTokenU': deviceTokenU ?? "",
      'userRole': userRole ?? '',
      'workerTimelineStep': workerTimelineStep.toString(),
      'companyTimelineStep': companyTimelineStep.toString(),
    };
  }

  // Convert Map<String, String> to AppUser object
  static Future<AppUser?> fromSp(Map<String, String> userMap) async {
    return AppUser(
      uid: userMap['uid'] ?? "",
      email: userMap['email'],
      language: userMap['language'],
      displayName: userMap['displayName'],
      photoUrl: userMap['photoUrl'],
      deviceTokenU: userMap['deviceTokenU'],
      userRole: userMap['userRole'],
      workerTimelineStep: int.parse(userMap['workerTimelineStep'] ?? '0'),
      companyTimelineStep: int.parse(userMap['companyTimelineStep'] ?? '0'),
    );
  }
}
