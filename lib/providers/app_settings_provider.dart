import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../data_providers/app_versions_data_provider.dart';
import '../utils/helpers/app_version.dart';
import '../views/old_common_views/components/update_app_dialog.dart';

part 'user_journey.dart';

class AppSettingsProvider with ChangeNotifier {
  String? _latestVersion;
  String? _androidUrl;
  String? _iOSUrl;
  bool? _shouldUpdate;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;

  AppSettingsProvider() {
    _auth.authStateChanges().listen((User? user) {
      _user = user;
      notifyListeners();
    });
    getDeviceId();
  }

  String? get latestVersion => _latestVersion;

  String? get androidUrl => _androidUrl;

  String? get iOSUrl => _iOSUrl;

  bool? get shouldUpdate => _shouldUpdate;

  // Global Keys for ShowCaseView
  GlobalKey searchBar = GlobalKey();
  GlobalKey translation = GlobalKey();
  GlobalKey selection = GlobalKey();
  GlobalKey signInButton = GlobalKey();
  GlobalKey bottomNavigation = GlobalKey();

  Future<bool?> _shouldUpdateApp() async {
    // bool shouldShowUpdateDialog = false;

    _latestVersion = '';
    _androidUrl = '';
    _iOSUrl = '';
    _shouldUpdate = false;

    Map shouldUpdateApp = await AppVersionsDataProvider().shouldUpdateApp();
    _latestVersion = shouldUpdateApp['version'] ?? "";

    String currentAppVersion = AppVersionHelper().get();

    if (shouldUpdateApp.containsKey('version') &&
        _latestVersion != "" &&
        Version.parse(_latestVersion!) > Version.parse(currentAppVersion)) {
      // print('versions are not the same');
      // print('current version: $currentAppVersion');
      // print('latest version: ' + shouldUpdateApp["version"]);

      _shouldUpdate = true;
      _iOSUrl = shouldUpdateApp['iOSUrl'];
      _androidUrl = shouldUpdateApp['androidUrl'];
      _latestVersion = shouldUpdateApp['version'];
    }

    return _shouldUpdate;
  }

  void checkForUpdate(BuildContext context) {
    if (!kIsWeb) {
      //_latestversion ==null means the update never checked before since the app is open
      // if (_latestVersion == null) {
      _shouldUpdateApp().then((value) {
        print("update: ${value!}");
        if (value) {
          showDialog(
            context: context,
            barrierDismissible:
                false, // Dialog cannot be dismissed by tapping outside
            builder: (BuildContext context) {
              return UpdateAppDialog(
                url: Platform.isAndroid ? _androidUrl ?? "" : _iOSUrl ?? "",
              );
            },
          );
        }
      });
      // }
    }
  }

  void notifyListners() {
    notifyListeners();
  }
}
