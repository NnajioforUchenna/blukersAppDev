import 'package:blukers/data_providers/industries_data_provider.dart';
import 'package:blukers/models/industry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart';

import '../models/job.dart';
import '../views/common_views/address_form/validate_address.dart';

class IndustriesProvider with ChangeNotifier {
  Map<String, Industry> _industries = {};
  Map<String, Industry> get industries => _industries;

  Map<String, Job> jobs = {};

  IndustriesProvider() {
    getData();
  }

  void getData() {
    IndustriesDataProvider.getAllIndustries().then((data) {
      _industries = data;
      notifyListeners();
      fillJobs();
    });
  }

  // Implement Address Autocomplete
  List<AutocompletePrediction> predictions = [];
  var selectedAddress = {};
  bool isSelectedAddress = false;

  void updateAddress(result) {
    isSelectedAddress = true;
    selectedAddress = result;
  }

  getPredictions(street) async {
    String address = '$street';

    if (street.isEmpty) {
      predictions = [];
      notifyListeners();
      return;
    }

    final places = FlutterGooglePlacesSdk(MYKEY);
    FindAutocompletePredictionsResponse findPredictions =
        await places.findAutocompletePredictions(address);
    predictions = findPredictions.predictions;
    notifyListeners();
  }

  Future<void> selectedPrediction(AutocompletePrediction prediction) async {
    Map<String, dynamic> result =
        await validateAddressFromSelection(prediction.fullText);
    print(result);
    if (result['isAddressValid']) {
      updateAddress(result['formattedAddress']);
    } else {
      var addressDic = parsePrediction(prediction);
      updateAddress(addressDic);
    }
    predictions = [];
    notifyListeners();
  }

  parsePrediction(AutocompletePrediction prediction) {
    var addressDic = {};
    List<String> parts = prediction.secondaryText.split(',');
    addressDic['street'] = prediction.primaryText;
    addressDic['country'] = parts.isNotEmpty ? parts.removeLast().trim() : '';
    addressDic['state'] = parts.isNotEmpty ? parts.removeLast().trim() : '';
    addressDic['city'] = parts.isNotEmpty ? parts.removeLast().trim() : '';

    return addressDic;
  }

  void fillJobs() {
    _industries.forEach((key, value) {
      value.jobs.forEach((job) {
        jobs[job.jobId] = job;
      });
    });
  }
}
