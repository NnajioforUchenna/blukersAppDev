import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/address.dart';
import '../models/job_post.dart';
import '../views/worker/services/services_components/products/products.dart';
import '../views/worker/services/services_components/subscription/subscription_components/mobile_view/subscription_mobile_view_widget.dart';

final List<String> routesWorker = [
  '/jobs',
  '/myJobs',
  '/search_jobs',
  '/offers',
  '/workerProfile',
  '/login'
];
final List<String> routesCompany = [
  '/workers',
  '/myJobPosts',
  '/search_workers',
  '/chat',
  '/offers',
  '/companyProfile',
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
    style: const TextStyle(
      fontSize: 13.0, // Adjust the font size as needed
      color: Colors.black,
      height: 1.5, // Adjust line height for better readability
    ),
    textAlign: TextAlign.left, // Align text to the left
  );
}

final List<Map<String, dynamic>> listProducts = [
  {
    "color": const Color(0xffF16523),
    "title": "FOIA",
    "subtitle": "",
    "amount": "299.99",
    "productId": "foia",
    "details": [
      ""
      // "Our team will verify your immigration status and will send you the results."
    ],
  },
  {
    "color": const Color(0xff1a75bb),
    "title": "Employment",
    "subtitle": "Verification",
    "amount": "99.99",
    "productId": "employmentVerification",
    "details": [
      ""
      // "Our team will verify your work experience and will send you a certification of employment verified."
    ],
  },
];

final List<Map<String, dynamic>> listSubscriptions = [
  {
    "color": const Color(0xffF29500),
    "title": "Basic",
    "subtitle": "",
    "amount": "0",
    "subscriptionId": "basic",
    "details": [
      "Create your Resume",
      // "Upload your Resume",
      // "Upload your Certifications",
      "Apply to 2 Jobs Daily",
      // "Show your profile on top in employers searchers section"
    ],
  },
  {
    "color": const Color(0xff1a75bb),
    "title": "Premium",
    "subtitle": "",
    "amount": "4.99",
    "subscriptionId": "blukers_workers_premium",
    "details": [
      "Create your Resume",
      "Upload your Resume",
      "Upload your Certifications",
      "Apply to 10 Jobs Daily",
      "Show your profile on top in employers searchers section"
    ],
  },
  {
    "color": const Color(0xffF16523),
    "title": "Premium",
    "subtitle": "Plus",
    "amount": "9.99",
    "subscriptionId": "blukers_workers_premium_plus",
    "details": [
      "Create your Resume",
      "Upload your Resume",
      "Upload your Certifications",
      "Apply to unlimited Jobs",
      "Show your profile on top in employers searchers section",
      "Display your immigration and employment verification status"
    ],
  },
];

final List<Map<String, dynamic>> listServices = [
  {
    'title': 'Subscriptions',
    'description':
        'Stay updated with the latest job opportunities in the USA tailored for international talents.',
    'route': '/membership',
    'service': const MobileSubscriptionWidget(),
    'color': const Color(0xffF16523)
  },
  {
    'title': 'Products',
    'description':
        'Our comprehensive suite of services ensures that international workers transition smoothly into their new roles in the USA.',
    'route': '/products',
    'service': const Products(),
    'color': const Color(0xff1a75bb)
  },
  // {
  //   'title': 'Exams',
  //   'description':
  //       'Prepare for relevant certifications and evaluations required for specific job roles in the USA.',
  //   'route': '/exams',
  //   'service': const ServiceComingSoonWidget(),
  //   'color': const Color(0xffF16523)
  // },
  // {
  //   'title': 'Courses',
  //   'description':
  //       'Skill-enhancement courses designed to make you more marketable to employers in the USA.',
  //   'route': '/courses',
  //   'service': const ServiceComingSoonWidget(),
  //   'color': const Color(0xff1a75bb)
  // },
  // {
  //   'title': 'Certifications',
  //   'description':
  //       'Real-world practical experiences to familiarize international talents with the US work environment.',
  //   'route': '/practicals',
  //   'service': const ServiceComingSoonWidget(),
  //   'color': const Color(0xffF16523)
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
  'basic': 'Basic',
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

String formatDateTime(int timestamp) {
  DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp);
  return DateFormat('MMMM dd, yyyy').format(date);
}

String getFirstChar(String input) {
  if (input.isEmpty) {
    return "#";
  }
  return input[0];
}

bool isWellFormedUrl(String url) {
  return Uri.tryParse(url)?.hasAbsolutePath ?? false;
}

String removeFirstWord(String sentence) {
  List<String> words = sentence.split(' '); // Split the sentence into words
  if (words.isNotEmpty) {
    // Check if there are any words to remove
    words.removeAt(0); // Remove the first word
    return words.join(' '); // Join the remaining words back into a sentence
  }
  return ''; // Return an empty string if there were no words
}

String getFirstWord(String sentence) {
  List<String> words = sentence.split(' '); // Split the sentence into words
  return words.isNotEmpty
      ? words.first
      : ''; // Return the first word or an empty string if none
}
