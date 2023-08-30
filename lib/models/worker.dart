import '../common_files/get_time_ago.dart';
import 'address.dart';
import 'reference.dart';
import 'work_experience.dart';

enum WorkStatus { activelyLooking, hired }

class Worker {
  String workerId;
  String firstName;
  String middleName;
  String lastName;
  List<String> emails;
  String phoneNumber;
  String workerBriefDescription;
  String profilePhotoUrl;
  List<String> industryIds;
  List<String> jobIds;
  List<String> skillIds;
  List<String> activeMemberships;
  int workStatus;
  List<Address> addresses;
  Address? address;
  int birthdate;
  int dateCreated;
  List<WorkExperience> workExperiences;
  List<Reference> references;
  List<String> savedJobPostIds;
  List<String> appliedJobPostIds;
  List<String> workerBadgeIds;
  List<String> certificationsIds;
  List<String> workerVerificationsIds;
  String pdfResumeUrl;
  String onlineResume;
  bool isVerified;
  bool isBasicProfileCompleted;
  bool isProfileUpdateNeeded;
  int createdAt;
  int modifiedAt;

  Worker({
    required this.workerId,
    this.firstName = '',
    this.middleName = '',
    this.lastName = '',
    this.emails = const [],
    this.phoneNumber = '',
    this.workerBriefDescription = '',
    this.profilePhotoUrl = 'https://picsum.photos/200/300',
    this.industryIds = const [],
    this.jobIds = const [],
    this.skillIds = const [],
    this.activeMemberships = const [],
    this.workStatus = 0,
    this.addresses = const [],
    this.address,
    this.birthdate = 0,
    this.dateCreated = 0,
    this.workExperiences = const [],
    this.references = const [],
    this.savedJobPostIds = const [],
    this.appliedJobPostIds = const [],
    this.workerBadgeIds = const [],
    this.certificationsIds = const [],
    this.workerVerificationsIds = const [],
    this.pdfResumeUrl = '',
    this.onlineResume = '',
    this.isVerified = false,
    this.isBasicProfileCompleted = false,
    this.isProfileUpdateNeeded = false,
    this.createdAt = 0,
    this.modifiedAt = 0,
  });

  get timeAgo => getTimeAgo(dateCreated.toString());
  get location =>
      addresses.isNotEmpty ? addresses.first.location : 'Location not set';

  Map<String, dynamic> toMap() {
    return {
      'workerId': workerId,
      if (firstName.isNotEmpty) 'firstName': firstName,
      if (middleName.isNotEmpty) 'middleName': middleName,
      if (lastName.isNotEmpty) 'lastName': lastName,
      if (emails.isNotEmpty) 'emails': emails,
      if (phoneNumber.isNotEmpty) 'phoneNumber': phoneNumber,
      if (workerBriefDescription.isNotEmpty)
        'workerBriefDescription': workerBriefDescription,
      if (profilePhotoUrl.isNotEmpty) 'profilePhotoUrl': profilePhotoUrl,
      if (industryIds.isNotEmpty) 'industryIds': industryIds,
      if (jobIds.isNotEmpty) 'jobIds': jobIds,
      if (skillIds.isNotEmpty) 'skillIds': skillIds,
      if (activeMemberships.isNotEmpty) 'activeMemberships': activeMemberships,
      if (workStatus != 0) 'workStatus': workStatus,
      // Assuming addresses have a meaningful toMap method
      if (addresses.isNotEmpty)
        'addresses': addresses.map((address) => address.toMap()).toList(),
      if (address != null) 'address': address!.toMap(),
      if (dateCreated != 0) 'dateCreated': dateCreated,
      if (birthdate != 0) 'birthdate': birthdate,
      // Assuming workExperiences have a meaningful toMap method
      if (workExperiences.isNotEmpty)
        'workExperiences':
            workExperiences.map((experience) => experience.toMap()).toList(),
      // Assuming references have a meaningful toMap method
      if (references.isNotEmpty)
        'references': references.map((reference) => reference.toMap()).toList(),
      if (savedJobPostIds.isNotEmpty) 'savedJobPostIds': savedJobPostIds,
      if (appliedJobPostIds.isNotEmpty) 'appliedJobPostIds': appliedJobPostIds,
      if (workerBadgeIds.isNotEmpty) 'workerBadgeIds': workerBadgeIds,
      if (certificationsIds.isNotEmpty) 'certificationsIds': certificationsIds,
      if (workerVerificationsIds.isNotEmpty)
        'workerVerificationsIds': workerVerificationsIds,
      if (pdfResumeUrl.isNotEmpty) 'pdfResumeUrl': pdfResumeUrl,
      if (onlineResume.isNotEmpty) 'onlineResume': onlineResume,
      if (isVerified) 'isVerified': isVerified,
      if (isBasicProfileCompleted)
        'isBasicProfileCompleted': isBasicProfileCompleted,
      if (isProfileUpdateNeeded) 'isProfileUpdateNeeded': isProfileUpdateNeeded,
      if (createdAt != 0) 'createdAt': createdAt,
      if (modifiedAt != 0) 'modifiedAt': modifiedAt,
    };
  }

  static Worker? fromMap(Map<String, dynamic> map) {
    try {
      return Worker(
        workerId: map['workerId'],
        firstName: map['firstName'] ?? '',
        middleName: map['middleName'] ?? '',
        lastName: map['lastName'] ?? '',
        emails: (map['emails'] as List?)?.cast<String>() ?? [],
        phoneNumber: map['phoneNumber'] ?? '',
        workerBriefDescription: map['workerBriefDescription'] ?? '',
        profilePhotoUrl: map['profilePhotoUrl'] ?? '',
        industryIds: (map['industryIds'] as List?)?.cast<String>() ?? [],
        jobIds: (map['jobIds'] as List?)?.cast<String>() ?? [],
        skillIds: (map['skillIds'] as List?)?.cast<String>() ?? [],
        activeMemberships:
            (map['activeMemberships'] as List?)?.cast<String>() ?? [],
        workStatus: map['workStatus'] != null
            ? int.parse(map['workStatus'].toString())
            : 0,
        addresses: (map['addresses'] as List?)
                ?.map((item) => Address.fromMap(item))
                .toList() ??
            [],
        address:
            map['address'] != null ? Address.fromMap(map['address']) : null,
        birthdate: map['birthdate'] != null
            ? int.parse(map['birthdate'].toString())
            : 0,
        dateCreated: map['dateCreated'] != null
            ? int.parse(map['dateCreated'].toString())
            : 0,
        workExperiences: (map['workExperiences'] as List?)
                ?.map((item) => WorkExperience.fromMap(item))
                .toList() ??
            [],
        references: (map['references'] as List?)
                ?.map((item) => Reference.fromMap(item))
                .toList() ??
            [],
        savedJobPostIds:
            (map['savedJobPostIds'] as List?)?.cast<String>() ?? [],
        appliedJobPostIds:
            (map['appliedJobPostIds'] as List?)?.cast<String>() ?? [],
        workerBadgeIds: (map['workerBadgeIds'] as List?)?.cast<String>() ?? [],
        certificationsIds:
            (map['certificationsIds'] as List?)?.cast<String>() ?? [],
        workerVerificationsIds:
            (map['workerVerificationsIds'] as List?)?.cast<String>() ?? [],
        pdfResumeUrl: map['pdfResumeUrl'] ?? '',
        onlineResume: map['onlineResume'] ?? '',
        isVerified: map['isVerified'] ?? false,
        isBasicProfileCompleted: map['isBasicProfileCompleted'] ?? false,
        isProfileUpdateNeeded: map['isProfileUpdateNeeded'] ?? false,
        createdAt: map['createdAt'] != null
            ? int.parse(map['createdAt'].toString())
            : 0,
        modifiedAt: map['modifiedAt'] != null
            ? int.parse(map['modifiedAt'].toString())
            : 0,
      );
    } catch (e) {
      print('An error occurred while creating the Worker object: $e');
      return null;
    }
  }

  @override
  String toString() {
    return toMap().toString();
  }
}
