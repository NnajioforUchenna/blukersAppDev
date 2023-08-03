import 'location.dart';

class WorkExperience {
  final String companyName;
  final Location? location;
  final String jobTitle;
  final String jobDescription;
  final DateTime jobStartDate;
  final DateTime? jobEndDate;
  final bool isCurrentlyWorking;

  WorkExperience({
    required this.companyName,
    this.location,
    required this.jobTitle,
    required this.jobDescription,
    required this.jobStartDate,
    this.jobEndDate,
    this.isCurrentlyWorking = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'companyName': companyName,
      'location': location?.toMap(),
      'jobTitle': jobTitle,
      'jobDescription': jobDescription,
      'jobStartDate': jobStartDate.toIso8601String(),
      'jobEndDate': jobEndDate?.toIso8601String(),
      'isCurrentlyWorking': isCurrentlyWorking,
    };
  }

  static WorkExperience fromMap(Map<String, dynamic> map) {
    return WorkExperience(
      companyName: map['companyName'],
      location:
          map['location'] != null ? Location.fromMap(map['location']) : null,
      jobTitle: map['jobTitle'],
      jobDescription: map['jobDescription'],
      jobStartDate: DateTime.parse(map['jobStartDate']),
      jobEndDate:
          map['jobEndDate'] != null ? DateTime.parse(map['jobEndDate']) : null,
      isCurrentlyWorking: map['isCurrentlyWorking'] ?? false,
    );
  }
}
