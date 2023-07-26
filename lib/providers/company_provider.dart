import 'package:flutter/material.dart';

import '../models/app_user.dart';
import '../models/company.dart';
// Assuming the file containing the Company class is named 'company.dart'.

class CompanyProvider with ChangeNotifier {
  Company? _company;

  Company? get company => _company;

  update(AppUser? user) {}

// Any other methods related to the Company can be added as required.
}
