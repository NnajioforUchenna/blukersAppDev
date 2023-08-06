import 'dart:ui'; //for mobile
import 'dart:html' as html; //for web

class DeviceLocale {
  String get() {
    Locale deviceLocale = window.locale; // or html.window.locale
    String langCode = deviceLocale.languageCode;
    return langCode.substring(0, 2).toLowerCase().toString();
  }
}
