import 'package:flutter/material.dart';

import '../common_files/Industries.dart';
import '../models/industry.dart';

class IndustriesProvider with ChangeNotifier {
  Map<String, Industry> _industries = {};

  Map<String, Industry> get industries => _industries;

  // Constructor
  IndustriesProvider() {
    getData();
  }

  // Fills the industries
  void getData() {
    _industries = fillIndustries();
  }

  // Future<void> fillNumberOfJobPosts() async {
  //   final data = await IndustriesDataProvider.getNumberOfJobPosts();
  //
  //   for (var doc in data) {
  //     final data = doc.data();
  //
  //     final jobId = data['jobId'] as String;
  //     final industryId = data['industryId'] as String;
  //     final totalJobs = data['totalJobs'] as int;
  //
  //     if (_industries.containsKey(industryId)) {
  //       if (_industries[industryId]!.jobs.containsKey(jobId)) {
  //         _industries[industryId]!.jobs[jobId]!.numberOfJobPosts = totalJobs;
  //       }
  //     }
  //   }
  //
  //   notifyListeners(); // Notify listeners after updating the industries map
  // }

  var selectedAddress = {};
  bool isSelectedAddress = false;

  void updateAddress(result) {
    isSelectedAddress = true;
    selectedAddress = result;
  }

  Map<String, Industry> fillIndustries() {
    Map<String, Industry> industries = {};

    for (var industryData in IndustriesData) {
      Industry industry = Industry.fromMap(industryData);
      industries[industry.industryId] = industry;
    }
    return industries;
  }
}
