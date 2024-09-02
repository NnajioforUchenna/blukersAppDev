import 'package:blukers/models/app_user/components/registration_status.dart';

import 'preference.dart';

class RegistrationDetails {
  // Login Details
  String email;
  String? registeredAs;

  // Basic Details
  String? phoneNumber;
  String? firstName;
  String? middleName;
  String? lastName;
  String? shortDescription;

  // Preferences
  Preference? jobsPreference;
  Preference? workersPreference;

  // Tracking Registration Status
  RegistrationStatus status;

  RegistrationDetails({
    required this.email,
    this.registeredAs,
    this.phoneNumber,
    this.firstName,
    this.middleName,
    this.lastName,
    this.shortDescription,
    this.jobsPreference,
    this.workersPreference,
    RegistrationStatus? status,
  }) : status = status ?? RegistrationStatus();

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'registeredAs': registeredAs,
      'phoneNumber': phoneNumber,
      'firstName': firstName,
      'middleName': middleName, // Added middleName
      'lastName': lastName,
      'shortDescription': shortDescription,
      'jobsPreference': jobsPreference?.toMap(),
      'workersPreference': workersPreference?.toMap(),
      'status': status.toMap(),
    };
  }

  factory RegistrationDetails.fromMap(Map<String, dynamic> map) {
    return RegistrationDetails(
      email: map['email'],
      registeredAs: map['registeredAs'],
      phoneNumber: map['phoneNumber'],
      firstName: map['firstName'],
      middleName: map['middleName'],
      lastName: map['lastName'],
      shortDescription: map['shortDescription'],
      jobsPreference: map['jobsPreference'] != null
          ? Preference.fromMap(map['jobsPreference'])
          : null,
      workersPreference: map['workersPreference'] != null
          ? Preference.fromMap(map['workersPreference'])
          : null,
      status: RegistrationStatus.fromMap(map['status']),
    );
  }
}
