import 'dart:io'; // if (dart.library.html) 'dart:html'

import 'package:blukers/models/app_user.dart';
import 'package:flutter/material.dart';

import '../models/subscription_model.dart';

class PaymentsProvider with ChangeNotifier {
  AppUser? appUser;

  // You'll initialize your payment SDKs here
  PaymentsProvider() {
    if (Platform.isIOS) {
      // Initialize In-app Purchase For IOS
    } else if (Platform.isAndroid) {
      // Initialize In-app Purchase For IOS
    } else {
      // Initialize Stripe
    }
  }

  update(AppUser? user) {
    appUser = user;
    notifyListeners();
  }

  Future<void> purchaseSubscription(SubscriptionModel subscription) async {
    if (Platform.isIOS) {
      // In-app Purchase Code
    } else if (Platform.isAndroid) {
      // Stripe Purchase Code
    } else {}
  }

// Add other functions as needed (e.g., verify, restore, etc.)
}
