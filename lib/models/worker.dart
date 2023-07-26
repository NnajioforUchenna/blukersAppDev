import 'address.dart';
import 'reference.dart';
import 'work_experience.dart';

enum WorkStatus { activelyLooking, hired }

class Worker {
  final String workerId;
  final String firstName;
  final String?
      middleName; // Made optional because not everyone has a middle name.
  final String lastName;
  final String? profilePhotoUrl;
  final List<String> industryIds;
  final List<String> jobPositionIds;
  final List<String> skillIds;
  final List<String>? activeMemberships;
  final WorkStatus workStatus;
  final List<Address>? addresses;
  final DateTime birthdate;
  final List<WorkExperience>? workExperiences;
  final List<Reference>? references;
  final List<String> savedJobPostIds;
  final List<String> appliedJobPostIds;
  final List<String> workerBadgeIds;
  final List<String> certificationsIds;
  final List<String> workerVerificationsIds;
  final String? pdfResumeUrl;
  final String? onlineResume;
  final bool isVerified;
  final bool isBasicProfileCompleted;
  final bool isProfileUpdateNeeded;

  Worker({
    required this.workerId,
    required this.firstName,
    this.middleName,
    required this.lastName,
    this.profilePhotoUrl,
    required this.industryIds,
    required this.jobPositionIds,
    required this.skillIds,
    this.activeMemberships,
    required this.workStatus,
    this.addresses,
    required this.birthdate,
    this.workExperiences,
    this.references,
    required this.savedJobPostIds,
    required this.appliedJobPostIds,
    required this.workerBadgeIds,
    required this.certificationsIds,
    required this.workerVerificationsIds,
    this.pdfResumeUrl,
    this.onlineResume,
    required this.isVerified,
    required this.isBasicProfileCompleted,
    required this.isProfileUpdateNeeded,
  });

  Map<String, dynamic> toMap() {
    return {
      'workerId': workerId,
      'firstName': firstName,
      'middleName': middleName,
      'lastName': lastName,
      'profilePhotoUrl': profilePhotoUrl,
      'industryIds': industryIds,
      'jobPositionIds': jobPositionIds,
      'skillIds': skillIds,
      'activeMemberships': activeMemberships,
      'workStatus': workStatus.index,
      'addresses': addresses?.map((address) => address.toMap()).toList(),
      'birthdate': birthdate.toIso8601String(),
      'workExperiences': workExperiences
          ?.map((we) => we.toMap())
          .toList(), // Assuming WorkExperience has toMap method
      'references': references
          ?.map((ref) => ref.toMap())
          .toList(), // Assuming Reference has toMap method
      'savedJobPostIds': savedJobPostIds,
      'appliedJobPostIds': appliedJobPostIds,
      'workerBadgeIds': workerBadgeIds,
      'certificationsIds': certificationsIds,
      'workerVerificationsIds': workerVerificationsIds,
      'pdfResumeUrl': pdfResumeUrl,
      'onlineResume': onlineResume,
      'isVerified': isVerified,
      'isBasicProfileCompleted': isBasicProfileCompleted,
      'isProfileUpdateNeeded': isProfileUpdateNeeded,
    };
  }

  // Inside the Worker class...

  static Worker fromMap(Map<String, dynamic> map) {
    return Worker(
      workerId: map['workerId'],
      firstName: map['firstName'],
      middleName: map['middleName'],
      lastName: map['lastName'],
      profilePhotoUrl: map['profilePhotoUrl'],
      industryIds: List<String>.from(map['industryIds']),
      jobPositionIds: List<String>.from(map['jobPositionIds']),
      skillIds: List<String>.from(map['skillIds']),
      activeMemberships: map['activeMemberships'] != null
          ? List<String>.from(map['activeMemberships'])
          : null,
      workStatus: WorkStatus.values[map['workStatus']],
      addresses: map['addresses'] != null
          ? (map['addresses'] as List)
              .map((addressMap) => Address.fromMap(addressMap))
              .toList()
          : null,
      birthdate: DateTime.parse(map['birthdate']),
      workExperiences: map['workExperiences'] != null
          ? (map['workExperiences'] as List)
              .map((weMap) => WorkExperience.fromMap(weMap))
              .toList()
          : null, // Assuming WorkExperience has fromMap method
      references: map['references'] != null
          ? (map['references'] as List)
              .map((refMap) => Reference.fromMap(refMap))
              .toList()
          : null, // Assuming Reference has fromMap method
      savedJobPostIds: List<String>.from(map['savedJobPostIds']),
      appliedJobPostIds: List<String>.from(map['appliedJobPostIds']),
      workerBadgeIds: List<String>.from(map['workerBadgeIds']),
      certificationsIds: List<String>.from(map['certificationsIds']),
      workerVerificationsIds: List<String>.from(map['workerVerificationsIds']),
      pdfResumeUrl: map['pdfResumeUrl'],
      onlineResume: map['onlineResume'],
      isVerified: map['isVerified'],
      isBasicProfileCompleted: map['isBasicProfileCompleted'],
      isProfileUpdateNeeded: map['isProfileUpdateNeeded'],
    );
  }
}
