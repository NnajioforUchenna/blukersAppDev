import 'package:flutter/material.dart';

import '../models/app_user.dart';

class UserProvider with ChangeNotifier {
  AppUser? _appUser;

  AppUser? get appUser => _appUser;

  UserProvider() {}
}
