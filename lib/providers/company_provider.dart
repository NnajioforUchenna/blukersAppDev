import 'package:bulkers/data_providers/company_data_provider.dart';
import 'package:flutter/material.dart';

import '../models/app_user.dart';
import '../models/company.dart';
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

  void fetchInterestingWorkers() {
    print('fetchInterestingWorkers called');
    if (appUser != null) {
      CompanyDataProvider.getInterestingWorkers(appUser!.uid).then((value) {
        print(appUser!.uid);
        for (var worker in value) {
          interestingWorkers[worker.workerId] = worker;
        }
        notifyListeners();
      });
    }
  }
}
