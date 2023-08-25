import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:blukers/data_providers/app_versions_data_provider.dart';

class AppVersionsProvider with ChangeNotifier {
  String? _latestVersion;
  String? _androidUrl;
  String? _iOSUrl;
  bool? _shouldUpdate;

  String? get latestVersion => _latestVersion;
  String? get androidUrl => _androidUrl;
  String? get iOSUrl => _iOSUrl;
  bool? get shouldUpdate => _shouldUpdate;

  shouldUpdateApp() async {
    // bool shouldShowUpdateDialog = false;

    _latestVersion = '';
    _androidUrl = '';
    _iOSUrl = '';
    _shouldUpdate = false;

    Map shouldUpdateApp = await AppVersionsDataProvider().shouldUpdateApp();

    if (shouldUpdateApp.containsKey('answer') &&
        shouldUpdateApp['answer'] == true) {
      //
      _latestVersion = shouldUpdateApp['latestVersion'];
      _androidUrl = shouldUpdateApp['androidUrl'];
      _iOSUrl = shouldUpdateApp['iOSUrl'];
      _shouldUpdate = true;
      //
    }

    return _shouldUpdate;
  }

  void notifyListners() {
    notifyListeners();
  }
}
