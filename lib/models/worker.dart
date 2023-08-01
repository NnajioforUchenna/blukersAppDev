import 'address.dart';
import 'reference.dart';
import 'work_experience.dart';

enum WorkStatus { activelyLooking, hired }

class Worker {
  String workerId;
  String firstName;
  String? middleName;
  String lastName;
  List<String> emails;
  String? workerBriefDescription;
  String? profilePhotoUrl;
  List<String>? industryIds;
  List<String>? jobPositionIds;
  List<String>? skillIds;
  List<String>? activeMemberships;
  WorkStatus? workStatus;
  List<Address>? addresses;
  DateTime? birthdate;
  List<WorkExperience>? workExperiences;
  List<Reference>? references;
  List<String>? savedJobPostIds;
  List<String>? appliedJobPostIds;
  List<String>? workerBadgeIds;
  List<String>? certificationsIds;
  List<String>? workerVerificationsIds;
  String? pdfResumeUrl;
  String? onlineResume;
  bool? isVerified;
  bool? isBasicProfileCompleted;
  bool? isProfileUpdateNeeded;

  Worker({
    required this.workerId,
    required this.firstName,
    required this.lastName,
    required this.emails,
    this.workerBriefDescription,
    this.profilePhotoUrl,
    this.industryIds,
    this.jobPositionIds,
    this.skillIds,
    this.activeMemberships,
    this.workStatus,
    this.addresses,
    this.birthdate,
    this.workExperiences,
    this.references,
    this.savedJobPostIds,
    this.appliedJobPostIds,
    this.workerBadgeIds,
    this.certificationsIds,
    this.workerVerificationsIds,
    this.pdfResumeUrl,
    this.onlineResume,
    this.isVerified,
    this.isBasicProfileCompleted,
    this.isProfileUpdateNeeded,
    required middleName,
  });

  Worker.fromSignUp({
    required this.workerId,
    required this.firstName,
    required this.lastName,
    required String email,
    required String this.workerBriefDescription,
  })  : emails = [email],
        isBasicProfileCompleted = true;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'workerId': workerId,
      'firstName': firstName,
      'lastName': lastName,
    };

    if (profilePhotoUrl != null) map['profilePhotoUrl'] = profilePhotoUrl;
    if (emails.isNotEmpty) map['emails'] = emails;
    if (industryIds != null) map['industryIds'] = industryIds;
    if (jobPositionIds != null) map['jobPositionIds'] = jobPositionIds;
    if (skillIds != null) map['skillIds'] = skillIds;
    if (birthdate != null && birthdate != DateTime.now()) {
      map['birthdate'] = birthdate!.toIso8601String();
    }
    if (savedJobPostIds != null) map['savedJobPostIds'] = savedJobPostIds;
    if (appliedJobPostIds != null) {
      map['appliedJobPostIds'] = appliedJobPostIds;
    }
    if (workerBadgeIds != null) map['workerBadgeIds'] = workerBadgeIds;
    if (certificationsIds != null) {
      map['certificationsIds'] = certificationsIds;
    }
    if (workerVerificationsIds != null) {
      map['workerVerificationsIds'] = workerVerificationsIds;
    }
    if (pdfResumeUrl != null) map['pdfResumeUrl'] = pdfResumeUrl;
    if (onlineResume != null) map['onlineResume'] = onlineResume;
    if (workerBriefDescription != null && workerBriefDescription!.isNotEmpty) {
      map['workerBriefDescription'] = workerBriefDescription;
    }
    if (activeMemberships != null && activeMemberships!.isNotEmpty) {
      map['activeMemberships'] = activeMemberships;
    }
    if (workStatus == WorkStatus.activelyLooking) {
      map['workStatus'] = 'activelyLooking';
    } else {
      map['workStatus'] = 'hired';
    }

    // Other checks for remaining properties
    if (addresses != null && addresses!.isNotEmpty) {
      map['addresses'] = addresses!.map((address) => address.toMap()).toList();
    }
    if (workExperiences != null && workExperiences!.isNotEmpty) {
      map['workExperiences'] =
          workExperiences!.map((exp) => exp.toMap()).toList();
    }
    if (references != null && references!.isNotEmpty) {
      map['references'] = references!.map((ref) => ref.toMap()).toList();
    }
    if (isVerified != null) {
      map['isVerified'] = isVerified;
    }
    if (isBasicProfileCompleted != null) {
      map['isBasicProfileCompleted'] = isBasicProfileCompleted;
    }
    if (isProfileUpdateNeeded != null) {
      map['isProfileUpdateNeeded'] = isProfileUpdateNeeded;
    }

    return map;
  }

  // Inside the Worker class...

  static Worker fromMap(Map<String, dynamic> map) {
    return Worker(
      workerId: map['workerId'] ?? '',
      firstName: map['firstName'] ?? '',
      middleName: map['middleName'] ?? '',
      lastName: map['lastName'] ?? '',
      profilePhotoUrl: map['profilePhotoUrl'] ?? '',
      industryIds: map['industryIds'] != null
          ? List<String>.from(map['industryIds'])
          : [],
      jobPositionIds: map['jobPositionIds'] != null
          ? List<String>.from(map['jobPositionIds'])
          : [],
      skillIds:
          map['skillIds'] != null ? List<String>.from(map['skillIds']) : [],
      activeMemberships: map['activeMemberships'] != null
          ? List<String>.from(map['activeMemberships'])
          : [],
      workStatus: map['workStatus'] == "activelyLooking"
          ? WorkStatus.activelyLooking
          : WorkStatus.hired,
      addresses: map['addresses'] != null
          ? (map['addresses'] as List)
              .map((addressMap) => Address.fromMap(addressMap))
              .toList()
          : [],
      birthdate: map['birthdate'] != null
          ? DateTime.parse(map['birthdate'])
          : DateTime.now(),
      workExperiences: map['workExperiences'] != null
          ? (map['workExperiences'] as List)
              .map((weMap) => WorkExperience.fromMap(weMap))
              .toList()
          : [],
      references: map['references'] != null
          ? (map['references'] as List)
              .map((refMap) => Reference.fromMap(refMap))
              .toList()
          : [],
      savedJobPostIds: map['savedJobPostIds'] != null
          ? List<String>.from(map['savedJobPostIds'])
          : [],
      appliedJobPostIds: map['appliedJobPostIds'] != null
          ? List<String>.from(map['appliedJobPostIds'])
          : [],
      workerBadgeIds: map['workerBadgeIds'] != null
          ? List<String>.from(map['workerBadgeIds'])
          : [],
      certificationsIds: map['certificationsIds'] != null
          ? List<String>.from(map['certificationsIds'])
          : [],
      workerVerificationsIds: map['workerVerificationsIds'] != null
          ? List<String>.from(map['workerVerificationsIds'])
          : [],
      pdfResumeUrl: map['pdfResumeUrl'] ?? '',
      onlineResume: map['onlineResume'] ?? '',
      isVerified: map['isVerified'] ?? false,
      isBasicProfileCompleted: map['isBasicProfileCompleted'] ?? false,
      isProfileUpdateNeeded: map['isProfileUpdateNeeded'] ?? false,
      workerBriefDescription: map['workerBriefDescription'] ?? "",
      emails: map['emails'] != null ? List<String>.from(map['emails']) : [],
    );
  }
}
