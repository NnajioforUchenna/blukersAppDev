import 'dart:async';

import 'package:bulkers/data_providers/company_data_provider.dart';
import 'package:flutter/material.dart';

import '../models/app_user.dart';
import '../models/company.dart';
import '../models/job_post.dart';
import '../models/worker.dart';
// Assuming the file containing the Company class is named 'company.dart'.

class CompanyProvider with ChangeNotifier {
  Company? _company;
  AppUser? appUser;

  Company? get company => _company;

  Map<String, Worker> interestingWorkers = {};

  update(AppUser? user) {
    print('update called i was listening');
    appUser = user;
    notifyListeners();
  }

  Stream<List<Worker>> getInterestingWorkersStream() {
    if (appUser?.uid == null) {
      return Stream.value([]); // This returns an empty stream
    }
    return CompanyDataProvider.fetchInterestingWorkers(appUser!.uid).stream;
  }

  Stream<List<JobPost>> getMyJobPostsStream() {
    if (appUser?.uid == null) {
      return Stream.value([]); // This returns an empty stream
    }
    return CompanyDataProvider.fetchMyJobPosts(appUser!.uid).stream;
  }

  @override
  void dispose() {
    CompanyDataProvider.streamDispose();
    super.dispose();
  }
}
