import 'package:bulkers/data_providers/industries_data_provider.dart';
import 'package:bulkers/models/industry.dart';
import 'package:flutter/material.dart';

class IndustriesProvider with ChangeNotifier {
  Map<String, Industry> _industries = {};

  Map<String, Industry> get industries => _industries;

  IndustriesProvider() {
    getData();
  }

  void getData() {
    IndustriesDataProvider.getAllIndustries().then((data) {
      _industries = data;
      notifyListeners();
    });
  }
}
