import 'package:flutter/material.dart';

import '../models/app_user/app_user.dart';

class AuthProvider with ChangeNotifier {
  AppUser? appUser;

  update(AppUser? user) {
    appUser = user;
    notifyListeners();
  }
}
