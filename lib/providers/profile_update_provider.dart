import 'package:blukers/data_providers/user_data_provider.dart';
import 'package:flutter/material.dart';

import '../models/app_user/app_user.dart';

class ProfileUpdateProvider extends ChangeNotifier {
  AppUser? appUser;

  update(AppUser? user) {
    appUser = user;
    updateUserInformation();
    notifyListeners();
  }

  //_______________________Profile User Information_______________________
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController middleNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  void updateUserInformation() {
    if (appUser != null && appUser?.registrationDetails != null) {
      firstNameController.text = appUser!.registrationDetails?.firstName ?? '';
      lastNameController.text = appUser!.registrationDetails?.lastName ?? '';
      middleNameController.text =
          appUser!.registrationDetails?.middleName ?? '';
      descriptionController.text =
          appUser!.registrationDetails?.shortDescription ?? '';
    }
  }

  void updateAppUserInformation() {
    if (appUser != null && appUser?.registrationDetails != null) {
      appUser!.registrationDetails!.firstName = firstNameController.text;
      appUser!.registrationDetails!.lastName = lastNameController.text;
      appUser!.registrationDetails!.middleName = middleNameController.text;
      appUser!.registrationDetails!.shortDescription =
          descriptionController.text;

      UserDataProvider.updateUser(appUser!);
    }

    notifyListeners();
  }
}
