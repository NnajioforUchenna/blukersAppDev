import 'package:bulkers/models/worker.dart';

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

  // New fields added
  bool? isLoginInformation;
  String? registeredAs;
  bool? isBasicInformation;
  bool? isContactInformation;
  bool? isRegistrationComplete;

  Worker? worker; // Added Worker parameter
  Company? company; // Added Company parameter
  Address? address;

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

    return data;
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
      worker: map['worker'] != null
          ? Worker.fromMap(map['worker'])
          : null, // Convert Map to Worker object
      company: map['company'] != null
          ? Company.fromMap(map['company'])
          : null, // Convert Map to Company object
      address: map['address'] != null
          ? Address.fromMap(map['address'])
          : null, // Convert Map to Address object
    );
  }

  @override
  String toString() {
    return toMap().toString();
  }
}
