import 'package:flutter/cupertino.dart';

import '../models/app_user/app_user.dart';

class RegistrationProvider with ChangeNotifier {
  AppUser? appUser;

  update(AppUser? user) {
    appUser = user;
    notifyListeners();
  }
}
