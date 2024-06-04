import 'package:flutter/material.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../data_providers/app_versions_data_provider.dart';
import '../data_providers/user_journey_data_provider.dart';
import '../utils/helpers/app_version.dart';

part 'user_journey.dart';

Map<String, Locale> supportedLocales = {
  'en': const Locale('en', 'US'), // English
  'es': const Locale('es', 'ES'), // Spanish
  'ar': const Locale('ar', 'AE'), // Arabic
  'bn': const Locale('bn', 'BD'), // Bengali
  'zh': const Locale('zh', 'CN'), // Chinese (Simplified)
  'fr': const Locale('fr', 'FR'), // French
  'de': const Locale('de', 'DE'), // German
  'hi': const Locale('hi', 'IN'), // Hindi
  'ig': const Locale('ig', 'NG'), // Igbo
  'it': const Locale('it', 'IT'), // Italian
  'ja': const Locale('ja', 'JP'), // Japanese
  'jv': const Locale('jv', 'ID'), // Javanese
  'ko': const Locale('ko', 'KR'), // Korean
  'pt': const Locale('pt', 'BR'), // Portuguese
  'ru': const Locale('ru', 'RU'), // Russian
  'tr': const Locale('tr', 'TR'), // Turkish
};

class AppSettingsProvider with ChangeNotifier {
  String? _latestVersion;
  String? _androidUrl;
  String? _iOSUrl;
  bool? _shouldUpdate;
  SharedPreferences? prefs;
  Locale myLocale = WidgetsBinding.instance.window.locale;
  bool hasShowcased = false;

  AppSettingsProvider() {
    initializeBlukersApp();
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
      _shouldUpdate = true;
      _iOSUrl = shouldUpdateApp['iOSUrl'];
      _androidUrl = shouldUpdateApp['androidUrl'];
      _latestVersion = shouldUpdateApp['version'];
    }

    return _shouldUpdate;
  }

  void checkForUpdate(BuildContext context) {
    // if (!kIsWeb) {
    //   _shouldUpdateApp().then((value) {
    //     if (value != null) {
    //       showDialog(
    //         context: context,
    //         barrierDismissible:
    //             false, // Dialog cannot be dismissed by tapping outside
    //         builder: (BuildContext context) {
    //           return UpdateAppDialog(
    //             url: Platform.isAndroid ? _androidUrl ?? "" : _iOSUrl ?? "",
    //           );
    //         },
    //       );
    //     }
    //   });
    //   // }
    // }
  }

  void setLocale(String? selectedLanguageCode) {
    myLocale = supportedLocales[selectedLanguageCode ?? 'en']!;
    notifyListeners();
  }

  setHasShowcased(bool bool) {
    hasShowcased = bool;
    prefs?.setBool('showcaseShown', bool);
    notifyListeners();
  }

  void regenerateKeys() {
    searchBar = GlobalKey();
    translation = GlobalKey();
    selection = GlobalKey();
    signInButton = GlobalKey();
    bottomNavigation = GlobalKey();
  }
}
