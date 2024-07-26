import 'dart:convert'; // Required for JSON encoding/decoding

import 'package:shared_preferences/shared_preferences.dart';

import '../models/app_user/app_user.dart';

class UserSharedPreferencesServices {
  static const String USER_KEY = 'user';

  // Create
  static Future<void> create(AppUser userMap) async {
    final prefs = await SharedPreferences.getInstance();
    String userString = json.encode(userMap.toMap());
    prefs.setString(USER_KEY, userString);
  }

  // Read
  static Future<AppUser?> read() async {
    final prefs = await SharedPreferences.getInstance();
    String? userString = prefs.getString(USER_KEY);
    if (userString != null) {
      Map<String, String> userMap =
          Map<String, String>.from(json.decode(userString));
      return AppUser.fromMap(userMap);
    }
    return null;
  }

  // Update
  static Future<void> update(AppUser userMap) async {
    return create(userMap); // Reusing the create method for updating
  }

  // Delete
  static Future<void> delete() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(USER_KEY);
  }

  // isUser
  static Future<bool> isUser() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(USER_KEY);
  }
}
