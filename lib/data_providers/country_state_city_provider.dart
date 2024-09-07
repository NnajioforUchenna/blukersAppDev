import 'package:country_state_city/country_state_city.dart' as countrystatecity;
import 'package:country_state_city/utils/city_utils.dart';
import 'package:country_state_city/utils/country_utils.dart';
import 'package:country_state_city/utils/state_utils.dart';
import 'package:flutter/material.dart';

class CountryStateCityProvider extends ChangeNotifier {
  Map<int, List<countrystatecity.Country>> countries = {};
  Map<int, List<countrystatecity.State>> states = {};
  Map<int, List<countrystatecity.City>> cities = {};
  Map<int, String> selectedCountry = {};
  Map<int, String> selectedState = {};
  Map<int, String> selectedCity = {};

  Future<void> getCountries(int index) async {
    countries[index] = await getAllCountries();
    notifyListeners();
  }

  Future<void> getStates(int index, String countryId) async {
    states[index] = await getStatesOfCountry(countryId);
    notifyListeners();
  }

  Future<void> getCities(int index, String countryId, String stateId) async {
    cities[index] = await getStateCities(countryId, stateId);
    notifyListeners();
  }

  void setSelectedCountry(int index, String country) {
    selectedCountry[index] = country;
    notifyListeners();
  }

  void setSelectedState(int index, String state) {
    selectedState[index] = state;
    notifyListeners();
  }

  void setSelectedCity(int index, String city) {
    selectedCity[index] = city;
    notifyListeners();
  }

  void disposeAll(int index) {
    countries[index] = [];
    states[index] = [];
    cities[index] = [];
    notifyListeners();
  }
}
