import 'address.dart';

class WorkExperience {
  final String companyName;
  final List<Address>? addresses; // Made it optional
  final String jobPosition;
  final String jobTitle;
  final String jobDescription;
  final DateTime jobStartDate;
  final DateTime?
      jobEndDate; // Nullable because the worker might still be working there

  WorkExperience({
    required this.companyName,
    this.addresses,
    required this.jobPosition,
    required this.jobTitle,
    required this.jobDescription,
    required this.jobStartDate,
    this.jobEndDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'companyName': companyName,
      'addresses': addresses?.map((address) => address.toMap()).toList(),
      'jobPosition': jobPosition,
      'jobTitle': jobTitle,
      'jobDescription': jobDescription,
      'jobStartDate': jobStartDate.toIso8601String(),
      'jobEndDate': jobEndDate?.toIso8601String(),
    };
  }

  static WorkExperience fromMap(Map<String, dynamic> map) {
    return WorkExperience(
      companyName: map['companyName'],
      addresses: map['addresses'] != null
          ? (map['addresses'] as List)
              .map((addressMap) => Address.fromMap(addressMap))
              .toList()
          : null,
      jobPosition: map['jobPosition'],
      jobTitle: map['jobTitle'],
      jobDescription: map['jobDescription'],
      jobStartDate: DateTime.parse(map['jobStartDate']),
      jobEndDate:
          map['jobEndDate'] != null ? DateTime.parse(map['jobEndDate']) : null,
    );
  }
}
