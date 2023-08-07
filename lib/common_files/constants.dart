import 'dart:convert';

import '../models/address.dart';
import '../models/job_post.dart';

final List<String> routesWorker = [
  '/jobs',
  '/myJobs',
  '/companyChat',
  '/workerProfile',
  '/login'
];
final List<String> routesCompany = [
  '/workers',
  '/myJobPosts',
  '/companyChat',
  'companyProfile',
  '/login'
];

String getAddressesInStringFormat(List<Address>? addresses) {
  if (addresses == null || addresses.isEmpty) {
    return 'No addresses available';
  }
  return addresses.map((address) => address.displayAddress()).join('\n');
}

String getSalaryType(SalaryType? salaryType) {
  if (salaryType == null) {
    return 'Not specified';
  }

  switch (salaryType) {
    case SalaryType.hourly:
      return 'Hourly';
    case SalaryType.daily:
      return 'Daily';
    case SalaryType.weekly:
      return 'Weekly';
    case SalaryType.biWeekly:
      return 'Bi-Weekly';
    case SalaryType.monthly:
      return 'Monthly';
    case SalaryType.yearly:
      return 'Yearly';
    default:
      return 'N/A';
  }
}

String getJobType(JobType jobType) {
  switch (jobType) {
    case JobType.fullTime:
      return 'Full Time';
    case JobType.partTime:
      return 'Part Time';
    case JobType.contract:
      return 'Contract';
    case JobType.specifiedTime:
      return 'Specified Time';
    default:
      return 'N/A';
  }
}

void prettyPrintMap(Map<String, dynamic> map) {
  JsonEncoder encoder = const JsonEncoder.withIndent('  ');
  String prettyPrint = encoder.convert(map);
  print(prettyPrint);
}
