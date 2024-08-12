part of 'app_settings_provider.dart';

extension UserJourney on AppSettingsProvider {
  Future<void> initializeBlukersApp() async {
    prefs = await SharedPreferences.getInstance();
    hasShowcased = prefs?.getBool('showcaseShown') ?? false;

    // Initialize User as Prospect if Device Id is not available
    String? deviceId = prefs?.getString('device_id');
    if (deviceId == null) {
      deviceId = const Uuid().v4();
      await prefs?.setString('device_id', deviceId);
      UserJourneyDataProvider.updateProspects(deviceId);
    }
  }
}
