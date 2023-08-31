import 'dart:io'; // if (dart.library.html) 'dart:html'

import 'package:blukers/models/app_user.dart';
import 'package:blukers/services/stripe_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../models/subscription_model.dart';

class PaymentsProvider with ChangeNotifier {
  AppUser? appUser;

  late Stream<SubscriptionStatus> status;
  late StripeData stripeData;
  bool isActiveMember = false;

  // You'll initialize your payment SDKs here
  PaymentsProvider() {
    if (kIsWeb) {
      // Initialize Stripe
      initializeStripe();
    } else {
      if (Platform.isIOS) {
        // In-app Purchase Code
      } else if (Platform.isAndroid) {
        // Stripe Purchase Code
      }
    }
  }

  update(AppUser? user) {
    appUser = user;
    notifyListeners();
  }

  Future<void> purchaseSubscription(SubscriptionModel subscription) async {
    if (kIsWeb) {
    } else {
      if (Platform.isIOS) {
        // In-app Purchase Code
      } else if (Platform.isAndroid) {
        // Stripe Purchase Code
      }
    }
  }

  Stream<SubscriptionStatus> checkSubscriptionStatus(
      String uid, StripeData stripeData) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    return firestore
        .collection("AppUsers")
        .doc(uid)
        .collection("subscriptions")
        .snapshots()
        .map((event) => _checkUserHaveActiveSubscription(event, stripeData));
  }

  SubscriptionStatus _checkUserHaveActiveSubscription(
      QuerySnapshot qs, StripeData stripeData) {
    for (var ds in qs.docs) {
      var status = ds.get("status");
      if (status == "trialing" || status == "active") {
        DocumentReference priceDocRef = ds.get("price");
        String currentPriceId = '';
        if (priceDocRef.id.contains(stripeData.employeePremiumPlusPriceId)) {
          currentPriceId = stripeData.employeePremiumPlusPriceId;
        } else if (priceDocRef.id.contains(stripeData.employeePremiumPriceId)) {
          currentPriceId = stripeData.employeePremiumPriceId;
        } else if (priceDocRef.id.contains(stripeData.employerPremiumPriceId)) {
          currentPriceId = stripeData.employerPremiumPriceId;
        }
        isActiveMember = true;
        notifyListeners();
        return SubscriptionStatus(
            status: status, activePriceId: currentPriceId, subIsActive: true);
      }
    }
    isActiveMember = false;
    notifyListeners();
    return SubscriptionStatus(
        status: "", activePriceId: "", subIsActive: false);
  }

  Future<void> initializeStripe() async {
    stripeData = await fetchStripeData();
    if (appUser != null && appUser!.uid.isNotEmpty) {
      status = checkSubscriptionStatus(appUser!.uid, stripeData);
    }
  }

  Future<String> payPremiumPlus() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentReference docRef = await firestore
        .collection("AppUsers")
        .doc(appUser!.uid)
        .collection("checkout_sessions")
        .add({
      "price": stripeData.employeePremiumPlusPriceId,
      "success_url": kIsWeb ? "http://localhost:50246/" : "https://success.com",
      "cancel_url": kIsWeb ? "http://localhost:50246/" : "https://cancel.com",
    });

    int attempts = 0;
    const maxAttempts = 3;
    const delayBetweenAttempts = Duration(seconds: 5); // Adjust as needed

    while (attempts < maxAttempts) {
      DocumentSnapshot snapshot = await docRef.snapshots().first;

      if (snapshot.exists) {
        Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
        if (data != null && data['url'] != null) {
          String checkOutUrl = data['url'];
          print(checkOutUrl);
          return checkOutUrl;
        }
      }

      attempts++;
      print(attempts);
      if (attempts < maxAttempts) {
        await Future.delayed(
            delayBetweenAttempts); // Wait before the next attempt
      }
    }

    print(
        "Document does not contain the expected data after $maxAttempts attempts.");
    return 'error';
  }

// Add other functions as needed (e.g., verify, restore, etc.)
}
