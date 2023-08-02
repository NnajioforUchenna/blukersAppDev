import 'address.dart';
import 'skill.dart';

enum JobUrgencyLevel { high, medium, low }

enum JobPostStatus { active, inactive }

enum JobType { fullTime, partTime, contract, specifiedTime }

class JobPost {
  final String jobPostId;
  final String companyId;
  final String? companyName;
  final String jobTitle;
  final String jobDescription;
  final String? companyImageUrl;
  final String requirements;
  final List<Skill> skills;
  final JobType jobType;
  final String? contractDuration;
  final String? salaryTypeId;
  final double? salaryAmount;
  final List<Address>? addresses;
  final List<String>? applicantUserIds;
  final List<String>? declineUserIds;
  final List<String>? interviewedUserIds;
  final List<String>? hiredUserIds;
  final int numberOfPositionsAvailable;
  final JobUrgencyLevel? jobUrgencyLevel;
  final JobPostStatus? jobPostStatus;

  // New fields
  final List<String> industryIds;
  final List<String> jobIds;

  JobPost({
    required this.jobPostId,
    required this.companyId,
    required this.companyName,
    required this.jobTitle,
    required this.jobDescription,
    this.companyImageUrl,
    required this.requirements,
    required this.skills,
    required this.jobType,
    this.contractDuration,
    this.salaryTypeId,
    this.salaryAmount,
    this.addresses,
    this.applicantUserIds,
    this.declineUserIds,
    this.interviewedUserIds,
    this.hiredUserIds,
    required this.numberOfPositionsAvailable,
    this.jobUrgencyLevel,
    this.jobPostStatus,
    required this.industryIds, // Updated
    required this.jobIds, // Updated
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {
      'companyId': companyId,
      'companyName': companyName,
      'jobTitle': jobTitle,
      'jobDescription': jobDescription,
      'requirements': requirements,
      'numberOfPositionsAvailable': numberOfPositionsAvailable,
      'jobType': jobType.index,
      'industryIds': industryIds,
      'jobIds': jobIds,
      'jobPostId': jobPostId,
    };

    // Check and add only if not null
    if (companyImageUrl != null) data['companyImageUrl'] = companyImageUrl;
    if (skills != null && skills.isNotEmpty)
      data['skills'] = skills.map((skill) => skill.toMap()).toList();
    if (contractDuration != null) data['contractDuration'] = contractDuration;
    if (salaryTypeId != null) data['salaryTypeId'] = salaryTypeId;
    if (salaryAmount != null) data['salaryAmount'] = salaryAmount;
    if (addresses != null && addresses!.isNotEmpty)
      data['addresses'] = addresses!.map((address) => address.toMap()).toList();
    if (applicantUserIds != null) data['applicantUserIds'] = applicantUserIds;
    if (declineUserIds != null) data['declineUserIds'] = declineUserIds;
    if (interviewedUserIds != null)
      data['interviewedUserIds'] = interviewedUserIds;
    if (hiredUserIds != null) data['hiredUserIds'] = hiredUserIds;
    if (jobUrgencyLevel != null)
      data['jobUrgencyLevel'] = jobUrgencyLevel!.index;
    if (jobPostStatus != null) data['jobPostStatus'] = jobPostStatus!.index;

    return data;
  }

  static JobPost fromMap(Map<String, dynamic> map) {
    return JobPost(
      jobPostId: map['jobPostId'] ?? '',
      companyId: map['companyId'] ?? '',
      companyName: map['companyName'] ?? '',
      jobTitle: map['jobTitle'] ?? '',
      jobDescription: map['jobDescription'] ?? '',
      companyImageUrl: map['companyImageUrl'],
      requirements: map['requirements'] ?? '',
      skills: map['skills'] != null
          ? (map['skills'] as List)
              .map((skillMap) => Skill.fromMap(skillMap))
              .toList()
          : [],
      contractDuration: map['contractDuration'],
      salaryTypeId: map['salaryTypeId'],
      salaryAmount: map['salaryAmount'] != null
          ? double.parse(map['salaryAmount'].toString())
          : null,
      addresses: map['addresses'] != null
          ? (map['addresses'] as List)
              .map((addressMap) => Address.fromMap(addressMap))
              .toList()
          : null,
      applicantUserIds: map['applicantUserIds'] != null
          ? List<String>.from(map['applicantUserIds'])
          : null,
      declineUserIds: map['declineUserIds'] != null
          ? List<String>.from(map['declineUserIds'])
          : null,
      interviewedUserIds: map['interviewedUserIds'] != null
          ? List<String>.from(map['interviewedUserIds'])
          : null,
      hiredUserIds: map['hiredUserIds'] != null
          ? List<String>.from(map['hiredUserIds'])
          : null,
      numberOfPositionsAvailable: map['numberOfPositionsAvailable'] != null
          ? int.parse(map['numberOfPositionsAvailable'].toString())
          : 0,
      jobType: JobType.values[map['jobType'] ?? 0],
      jobUrgencyLevel: map['jobUrgencyLevel'] != null
          ? JobUrgencyLevel.values[map['jobUrgencyLevel']]
          : null,
      jobPostStatus: map['jobPostStatus'] != null
          ? JobPostStatus.values[map['jobPostStatus']]
          : null,
      industryIds: map['industryIds'] != null
          ? List<String>.from(map['industryIds'])
          : [],
      jobIds: map['jobIds'] != null ? List<String>.from(map['jobIds']) : [],
    );
  }

  @override
  String toString() {
    return toMap().toString();
  }
}
