part of 'app_settings_provider.dart';

extension UserJourney on AppSettingsProvider {
  // static DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  // static AndroidDeviceInfo? androidInfo;
  // static IosDeviceInfo? iosInfo;
  // static WebBrowserInfo? webBrowserInfo;
  //
  // Future<void> getDeviceDetails() async {
  //   try {
  //     if (kIsWeb) {
  //       webBrowserInfo = await deviceInfo.webBrowserInfo;
  //       print('Running on ${webBrowserInfo!.browserName}'); // e.g. "Chrome"
  //       // Generate a UUID for the web client
  //       var uuid = const Uuid();
  //       String webUniqueId = uuid.v4();
  //       print('Unique ID: $webUniqueId');
  //     } else if (Platform.isAndroid) {
  //       androidInfo = await deviceInfo.androidInfo;
  //       print('Running on ${androidInfo!.model}'); // e.g. "Moto G (4)"
  //       print('Android Device ID: ${androidInfo!.id}');
  //     } else if (Platform.isIOS) {
  //       iosInfo = await deviceInfo.iosInfo;
  //       print('Running on ${iosInfo!.utsname.machine}'); // e.g. "iPhone7,2"
  //       print('iOS Device ID: ${iosInfo!.identifierForVendor}');
  //     }
  //   } catch (e) {
  //     print('Failed to get platform version: $e');
  //   }
  // }

  Future<void> getDeviceId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? deviceId = prefs.getString('device_id');

    if (deviceId == null) {
      deviceId = const Uuid().v4();
      await prefs.setString('device_id', deviceId);
      updateProspects(deviceId);
    }

    print('Device ID: $deviceId');
  }

  Future<void> updateProspects(String deviceId) async {
    int currentTime = DateTime.now().millisecondsSinceEpoch;
    await FirebaseFirestore.instance.collection('prospects').doc(deviceId).set({
      'prospect_uid': deviceId,
      'first_load_time': currentTime,
    });
  }
}
