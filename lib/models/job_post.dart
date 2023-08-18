import '../common_files/get_time_ago.dart';
import 'address.dart';

enum JobUrgencyLevel { low, medium, high }

enum JobPostStatus { active, inactive }

enum JobType {
  fullTime,
  partTime,
  contract,
  specifiedTime,
  fullTimePermanent,
  fullTimeTemporary,
  internship,
}

enum SalaryType { hourly, daily, weekly, biWeekly, monthly, yearly }

class JobPost {
  String jobPostId;
  String companyId;
  String companyName;
  String jobTitle;
  String jobDescription;
  String companyLogo;
  String requirements;
  List<String> skills;
  JobType jobType;
  String contractDuration;
  SalaryType salaryType;
  double salaryAmount;
  Address? address;
  List<String> applicantUserIds;
  List<String> declineUserIds;
  List<String> interviewedUserIds;
  List<String> hiredUserIds;
  int numberOfPositionsAvailable;
  JobUrgencyLevel jobUrgencyLevel;
  JobPostStatus jobPostStatus;
  int dateCreated;
  String schedule;
  // New fields
  List<String> industryIds;
  List<String> jobIds;

  JobPost({
    this.jobPostId = '',
    this.companyId = '',
    this.companyName = '',
    this.jobTitle = '',
    this.jobDescription = '',
    this.companyLogo = '',
    this.requirements = '',
    this.skills = const [],
    this.jobType = JobType.fullTime,
    this.contractDuration = '',
    this.salaryType = SalaryType.hourly,
    this.salaryAmount = 0.0,
    this.applicantUserIds = const [],
    this.declineUserIds = const [],
    this.interviewedUserIds = const [],
    this.hiredUserIds = const [],
    this.numberOfPositionsAvailable = 0,
    this.jobUrgencyLevel = JobUrgencyLevel.high,
    this.jobPostStatus = JobPostStatus.active,
    this.industryIds = const [],
    this.jobIds = const [],
    this.dateCreated = 0,
    this.schedule = '',
    this.address, // Needs to be passed or made nullable
  });

  get timeAgo => getTimeAgo(dateCreated.toString());

  get location => address != null ? address!.location : '';

  Map<String, dynamic> toMap() {
    return {
      if (jobPostId.isNotEmpty) 'jobPostId': jobPostId,
      if (companyId.isNotEmpty) 'companyId': companyId,
      if (companyName.isNotEmpty) 'companyName': companyName,
      if (jobTitle.isNotEmpty) 'jobTitle': jobTitle,
      if (jobDescription.isNotEmpty) 'jobDescription': jobDescription,
      if (companyLogo.isNotEmpty) 'companyLogo': companyLogo,
      if (requirements.isNotEmpty) 'requirements': requirements,
      if (skills.isNotEmpty) 'skills': skills,
      if (jobType != JobType.fullTime) 'jobType': jobType.index,
      if (contractDuration.isNotEmpty) 'contractDuration': contractDuration,
      if (salaryType != SalaryType.hourly) 'salaryType': salaryType.index,
      if (salaryAmount != 0.0) 'salaryAmount': salaryAmount,
      if (address != null) 'address': address!.toMap(),
      if (applicantUserIds.isNotEmpty) 'applicantUserIds': applicantUserIds,
      if (declineUserIds.isNotEmpty) 'declineUserIds': declineUserIds,
      if (interviewedUserIds.isNotEmpty)
        'interviewedUserIds': interviewedUserIds,
      if (hiredUserIds.isNotEmpty) 'hiredUserIds': hiredUserIds,
      if (numberOfPositionsAvailable != 0)
        'numberOfPositionsAvailable': numberOfPositionsAvailable,
      if (jobUrgencyLevel != JobUrgencyLevel.high)
        'jobUrgencyLevel': jobUrgencyLevel.index,
      if (jobPostStatus != JobPostStatus.active)
        'jobPostStatus': jobPostStatus.index,
      if (dateCreated != 0) 'dateCreated': dateCreated,
      if (schedule.isNotEmpty) 'schedule': schedule,
      if (industryIds.isNotEmpty) 'industryIds': industryIds,
      if (jobIds.isNotEmpty) 'jobIds': jobIds,
    };
  }

  static JobPost? fromMap(Map<String, dynamic> map) {
    try {
      return JobPost(
        jobPostId: map['jobPostId']?.toString() ?? '',
        companyId: map['companyId']?.toString() ?? '',
        companyName: map['companyName']?.toString() ?? '',
        jobTitle: map['jobTitle']?.toString() ?? '',
        jobDescription: map['jobDescription']?.toString() ?? '',
        companyLogo: map['companyLogo']?.toString() ?? '',
        requirements: map['requirements']?.toString() ?? '',
        skills: map['skills']?.cast<String>() ?? const [],
        jobType: JobType.values[map['jobType'] ?? JobType.fullTime.index],
        contractDuration: map['contractDuration']?.toString() ?? '',
        salaryType:
            SalaryType.values[map['salaryType'] ?? SalaryType.hourly.index],
        salaryAmount: map['salaryAmount'] != null
            ? double.parse(map['salaryAmount'].toString())
            : 0.0,
        address:
            map['address'] != null ? Address.fromMap(map['address']) : null,
        applicantUserIds: map['applicantUserIds']?.cast<String>() ?? const [],
        declineUserIds: map['declineUserIds']?.cast<String>() ?? const [],
        interviewedUserIds:
            map['interviewedUserIds']?.cast<String>() ?? const [],
        hiredUserIds: map['hiredUserIds']?.cast<String>() ?? const [],
        numberOfPositionsAvailable: map['numberOfPositionsAvailable'] != null
            ? int.parse(map['numberOfPositionsAvailable'].toString())
            : 0,
        jobUrgencyLevel: JobUrgencyLevel
            .values[map['jobUrgencyLevel'] ?? JobUrgencyLevel.high.index],
        jobPostStatus: JobPostStatus
            .values[map['jobPostStatus'] ?? JobPostStatus.active.index],
        industryIds: map['industryIds']?.cast<String>() ?? const [],
        jobIds: map['jobIds']?.cast<String>() ?? const [],
        dateCreated: map['dateCreated'] != null
            ? int.parse(map['dateCreated'].toString())
            : 0,
        schedule: map['schedule']?.toString() ?? '',
      );
    } catch (e, stackTrace) {
      print("Error creating JobPost: $e");
      print("Stack trace: $stackTrace");
      return null;
    }
  }

  @override
  String toString() {
    return toMap().toString();
  }
}
