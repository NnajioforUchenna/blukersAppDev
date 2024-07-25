import 'jobs_perference.dart';

class RegistrationDetails {
  // Login Details
  String email;
  String registeredAs;

  // Basic Details
  String phoneNumber;
  String firstName;
  String? middleName;
  String lastName;
  String? shortDescription;

  // Preferences
  Preference? jobsPreference;
  Preference? workersPreference;

  RegistrationDetails({
    required this.email,
    required this.registeredAs,
    required this.phoneNumber,
    required this.firstName,
    this.middleName,
    required this.lastName,
    this.shortDescription,
    this.jobsPreference,
    this.workersPreference,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'registeredAs': registeredAs,
      'phoneNumber': phoneNumber,
      'firstName': firstName,
      'middleName': middleName,
      'lastName': lastName,
      'shortDescription': shortDescription,
      'jobsPreference': jobsPreference?.toMap(),
      'workersPreference': workersPreference?.toMap(),
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
    );
  }
}
