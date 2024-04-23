part of 'app_settings_provider.dart';

extension UserJourney on AppSettingsProvider {
  Future<void> getDeviceId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? deviceId = prefs.getString('device_id');

    if (deviceId == null) {
      deviceId = const Uuid().v4();
      await prefs.setString('device_id', deviceId);
      UserJourneyDataProvider.updateProspects(deviceId);
    }
  }
}
