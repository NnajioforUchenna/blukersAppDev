import 'package:flutter/material.dart';

import '../models/app_user.dart';

class UserProvider with ChangeNotifier {
  AppUser? _appUser;

  String userType = "worker";

  AppUser? get appUser => _appUser;

  UserProvider() {}
}
