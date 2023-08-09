import '../common_files/get_time_ago.dart';
import 'address.dart';
import 'skill.dart';

enum JobUrgencyLevel { high, medium, low }

enum JobPostStatus { active, inactive }

enum JobType { fullTime, partTime, contract, specifiedTime }

enum SalaryType { hourly, daily, weekly, biWeekly, monthly, yearly }

class JobPost {
  String? jobPostId = '';
  String companyId;
  String? companyName;
  String jobTitle;
  String jobDescription;
  String? companyLogo;
  String requirements;
  List<Skill> skills;
  JobType jobType;
  String? contractDuration;
  SalaryType? salaryType;
  double? salaryAmount;
  List<Address>? addresses;
  Address? address;
  List<String>? applicantUserIds = [];
  List<String>? declineUserIds;
  List<String>? interviewedUserIds;
  List<String>? hiredUserIds;
  int numberOfPositionsAvailable;
  JobUrgencyLevel? jobUrgencyLevel;
  JobPostStatus? jobPostStatus;
  int? dateCreated;
  String? schedule;

  // New fields
  List<String> industryIds;
  List<String> jobIds;

  JobPost({
    required this.jobPostId,
    required this.companyId,
    required this.companyName,
    required this.jobTitle,
    required this.jobDescription,
    this.companyLogo,
    required this.requirements,
    required this.skills,
    required this.jobType,
    this.contractDuration,
    this.salaryType,
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
    this.dateCreated,
    this.schedule,
    this.address,
  });

  get timeAgo => getTimeAgo(dateCreated.toString());

  get location => addresses?.first.location ?? 'Location not set';

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
      'schedule': schedule ?? 'Schedule not set',
    };

    // Check and add only if not null
    if (dateCreated != null) data['dateCreated'] = dateCreated;

    if (companyLogo != null) data['companyLogo'] = companyLogo;
    if (skills != null && skills.isNotEmpty)
      data['skills'] = skills.map((skill) => skill.toMap()).toList();
    if (contractDuration != null) data['contractDuration'] = contractDuration;

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
    if (salaryType != null) data['salaryType'] = salaryType!.index;
    if (address != null) data['address'] = address!.toMap();

    return data;
  }

  static JobPost fromMap(Map<String, dynamic> map) {
    int mapDateCreated = 0;
    try {
      mapDateCreated =
          map['dateCreated'] ?? DateTime.now().millisecondsSinceEpoch;
    } catch (e) {
      mapDateCreated = DateTime.now().millisecondsSinceEpoch;
    }

    return JobPost(
      dateCreated: mapDateCreated,
      jobPostId: map['jobPostId'] ?? '',
      companyId: map['companyId'] ?? '',
      companyName: map['companyName'] ?? '',
      jobTitle: map['jobTitle'] ?? '',
      jobDescription: map['jobDescription'] ?? '',
      companyLogo: map['companyLogo'],
      requirements: map['requirements'] ?? '',
      schedule: map['schedule'] ?? '',
      skills: map['skills'] != null
          ? (map['skills'] as List)
              .map((skillMap) => Skill.fromMap(skillMap))
              .toList()
          : [],
      contractDuration: map['contractDuration'],
      salaryType: map['salaryType'] != null
          ? SalaryType.values[map['salaryType']]
          : null,
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
          : [],
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
      address: map['address'] != null ? Address.fromMap(map['address']) : null,
    );
  }

  @override
  String toString() {
    return toMap().toString();
  }
}
