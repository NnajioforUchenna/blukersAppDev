import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb;

bool isIOS() {
  if (kIsWeb) {
    return false; // or handle web-specific logic
  }
  // If not web, you can safely use Platform.isIOS
  return Platform.isIOS;
}

bool isAndroid() {
  if (kIsWeb) {
    return false; // or handle web-specific logic
  }
  // If not web, you can safely use Platform.isAndroid
  return Platform.isAndroid;
}
