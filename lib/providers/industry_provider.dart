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
    if (parts.length >= 2) {
      addressDic['city'] = parts[0].trim();
      addressDic['state'] = parts[1].trim();
      addressDic['country'] = parts[2].trim();
    }

    return addressDic;
  }
}
