import 'package:bulkers/data_providers/industries_data_provider.dart';
import 'package:bulkers/models/industry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart';

import '../views/common_views/address_form/validate_address.dart';

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

  // Implement Address Autocomplete
  List<AutocompletePrediction> predictions = [];

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

    List<dynamic> listPredicts = findPredictions.predictions;
    predictions = findPredictions.predictions;
    notifyListeners();

    listPredicts.forEach((element) {
      print(element);
      print('');
    });
  }

  void selectedPrediction(AutocompletePrediction prediction) {
    validateAddressFromSelection(prediction.fullText);
    predictions = [];
    notifyListeners();
  }
}
