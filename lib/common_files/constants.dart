import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/address.dart';
import '../models/job_post.dart';

final List<String> routesWorker = [
  '/jobs',
  '/myJobs',
  '/companyChat',
  '/offers',
  '/workerProfile',
  '/login'
];
final List<String> routesCompany = [
  '/workers',
  '/myJobPosts',
  '/companyChat',
  '/offers',
  'companyProfile',
  '/login'
];

String getAddressesInStringFormat(Address? address) {
  if (address == null) {
    return 'Not specified';
  }
  return address.displayAddress();
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
    case JobType.fullTimePermanent:
      return 'Full Time, Permanent';
    case JobType.fullTimeTemporary:
      return 'Full Time, Seasonal';
    default:
      return 'N/A';
  }
}

void prettyPrintMap(Map<String, dynamic> map) {
  JsonEncoder encoder = const JsonEncoder.withIndent('  ');
  String prettyPrint = encoder.convert(map);
  print(prettyPrint);
}

String toTitleCase(String text) {
  return text
      .trim()
      .split(' ')
      .map((word) => word.isNotEmpty
          ? word[0].toUpperCase() + word.substring(1).toLowerCase()
          : '')
      .join(' ');
}

Widget displayParagraph(String text) {
  // Adding two newlines after every period
  String formattedText = text.replaceAll('. ', '.\n\n');

  return Text(
    formattedText,
    style: TextStyle(
      fontSize: 13.0, // Adjust the font size as needed
      color: Colors.black,
      height: 1.5, // Adjust line height for better readability
    ),
    textAlign: TextAlign.left, // Align text to the left
  );
}

final List<Map<String, String>> listOffers = [
  {
    'title': 'Subscriptions',
    'description':
        'Stay updated with the latest job opportunities in the USA tailored for international talents.',
    'route': '/membership'
  },
  {
    'title': 'Services',
    'description':
        'Our comprehensive suite of services ensures that international workers transition smoothly into their new roles in the USA.',
    'route': '/services'
  },
  // {
  //   'title': 'Exams',
  //   'description':
  //       'Prepare for relevant certifications and evaluations required for specific job roles in the USA.',
  //   'route': '/exams'
  // },
  // {
  //   'title': 'Courses',
  //   'description':
  //       'Skill-enhancement courses designed to make you more marketable to employers in the USA.',
  //   'route': '/courses'
  // },
  // {
  //   'title': 'Certifications',
  //   'description':
  //       'Real-world practical experiences to familiarize international talents with the US work environment.',
  //   'route': '/practicals'
  // },
];

List<List<Widget>> combineLists(List<Widget> list1, List<Widget> list2) {
  return List<List<Widget>>.generate(
      list1.length, (index) => [list1[index], list2[index]]);
}

String sanitizeJson(String jsonString) {
  return jsonString.replaceAll('NaN', 'null');
}

String extractSessionId(String checkoutUrl) {
  Uri uri = Uri.parse(checkoutUrl);
  String path = uri.path;
  RegExp regExp = RegExp(r'cs_test_[\w]+');
  Match? match = regExp.firstMatch(path);

  if (match != null) {
    return match.group(0) ?? '';
  } else {
    return '';
  }
}

Map<String, String?> extractIds(String text) {
  RegExp userIdRegExp = RegExp(r"user_id=([^?]+)");
  RegExp transactionIdRegExp = RegExp(r"transaction_Id=(\d+)");

  String? userId = userIdRegExp.firstMatch(text)?.group(1);
  String? transactionId = transactionIdRegExp.firstMatch(text)?.group(1);

  return {
    'user_id': userId,
    'transaction_Id': transactionId,
  };
}

const ProductNames = {
  'blukers_workers_premium': 'Premium',
  'blukers_workers_premium_plus': 'Premium Plus',
};

const ProductPrices = {
  'blukers_workers_premium': 4.99,
  'blukers_workers_premium_plus': 9.99,
};

String formatDate(int timestamp) {
  DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp);
  return DateFormat('MMM d, y').format(date);
}
