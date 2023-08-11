import 'package:devicelocale/devicelocale.dart';

class DeviceLocale {
  static get() async {
    dynamic locale = await Devicelocale.currentLocale;
    locale = locale.substring(0, 2).toLowerCase().toString();
    return locale;
  }
}
