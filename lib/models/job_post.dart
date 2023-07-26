import 'address.dart';
import 'skill.dart';

enum JobUrgencyLevel { high, medium, low }

enum JobPostStatus { active, inactive }

enum JobType { fullTime, partTime, contract, specifiedTime }

class JobPost {
  final String companyId;
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

  JobPost({
    required this.companyId,
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
  });
  Map<String, dynamic> toMap() {
    return {
      'companyId': companyId,
      'jobTitle': jobTitle,
      'jobDescription': jobDescription,
      'companyImageUrl': companyImageUrl,
      'requirements': requirements,
      'skills': skills.map((skill) => skill.toMap()).toList(),
      'contractDuration': contractDuration,
      'salaryTypeId': salaryTypeId,
      'salaryAmount': salaryAmount,
      'addresses': addresses?.map((address) => address.toMap()).toList(),
      'applicantUserIds': applicantUserIds,
      'declineUserIds': declineUserIds,
      'interviewedUserIds': interviewedUserIds,
      'hiredUserIds': hiredUserIds,
      'numberOfPositionsAvailable': numberOfPositionsAvailable,
      'jobType': jobType.index,
      'jobUrgencyLevel': jobUrgencyLevel?.index,
      'jobPostStatus': jobPostStatus?.index,
    };
  }

  static JobPost fromMap(Map<String, dynamic> map) {
    return JobPost(
      companyId: map['companyId'],
      jobTitle: map['jobTitle'],
      jobDescription: map['jobDescription'],
      companyImageUrl: map['companyImageUrl'],
      requirements: map['requirements'],
      skills: (map['skills'] as List)
          .map((skillMap) => Skill.fromMap(skillMap))
          .toList(),
      contractDuration: map['contractDuration'],
      salaryTypeId: map['salaryTypeId'],
      salaryAmount: map['salaryAmount'],
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
      numberOfPositionsAvailable: map['numberOfPositionsAvailable'],
      jobType: JobType.values[map['jobType']],
      jobUrgencyLevel: map['jobUrgencyLevel'] != null
          ? JobUrgencyLevel.values[map['jobUrgencyLevel']]
          : null,
      jobPostStatus: map['jobPostStatus'] != null
          ? JobPostStatus.values[map['jobPostStatus']]
          : null,
    );
  }

  @override
  String toString() {
    return toMap().toString();
  }
}
