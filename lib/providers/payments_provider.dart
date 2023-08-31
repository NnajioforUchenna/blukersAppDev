import 'dart:io';

import 'package:blukers/common_files/mock_data.dart';
import 'package:blukers/models/app_user.dart';
import 'package:blukers/services/stripe_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:universal_html/html.dart' as html;

import '../models/subscription_model.dart';
import '../views/membership/subscription_components/countdown_waiting_page.dart';

part 'apple_payment_provider.dart';

class PaymentsProvider with ChangeNotifier {
  AppUser? appUser;

  // In-app Purchase parameters
  late final InAppPurchase _iap;
  late final Stream<List<PurchaseDetails>> purchaseUpdated;
  final Set<String> _kProductIds = <String>{'blukers_499_1m'};
  List<ProductDetails> products = mockProducts; // [];

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
        initializeApplePayment();
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

  Future<String> getCheckOutUrl(priceId, successUrl, failedUrl) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentReference docRef = await firestore
        .collection("AppUsers")
        .doc(appUser!.uid)
        .collection("checkout_sessions")
        .add({
      "price": priceId,
      "success_url": successUrl,
      "cancel_url": failedUrl,
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
      if (attempts < maxAttempts) {
        await Future.delayed(
            delayBetweenAttempts); // Wait before the next attempt
      }
    }

    return 'error';
  }

  String getPaymentPlatformName() {
    if (kIsWeb) {
      return "Stripe";
    } else {
      if (Platform.isIOS) {
        return "Apple";
      } else if (Platform.isAndroid) {
        return "Google";
      }
    }
    return "Stripe";
  }

  Future<void> pay4Subscription(
      BuildContext context, String subscriptionType) async {
    // Determine User's Platform
    String paymentPlatform = getPaymentPlatformName();
    // Show Countdown Waiting Page
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => CountDown(
                platform: paymentPlatform,
              )),
    );
    // connect the payment platform
    if (paymentPlatform == "Stripe") {
      getStripePayment(context, subscriptionType);
    } else if (paymentPlatform == "Apple") {
      // In-app Purchase Code
      getApplePayment(context, subscriptionType);
    } else if (paymentPlatform == "Google") {
      // Stripe Purchase Code
    }
  }

  Future<void> getStripePayment(
      BuildContext context, String subscriptionType) async {
    String priceId = "";
    if (subscriptionType == "premium") {
      priceId = stripeData.employeePremiumPriceId;
    } else {
      priceId = stripeData.employeePremiumPlusPriceId;
    }

    String urlEx = Uri.base.toString();
    String baseUrl = Uri.parse(urlEx).removeFragment().toString();
    String successUrl = baseUrl + 'paymentSuccess';
    String failedUrl = baseUrl + 'paymentFailed';

    String checkOutUrl = await getCheckOutUrl(priceId, successUrl, failedUrl);

    if (checkOutUrl == 'error') {
      EasyLoading.show(
        status: 'An Error Occurred While Getting Stripe Payment...',
        maskType: EasyLoadingMaskType.black,
      );

      // Delay for 5 seconds
      await Future.delayed(const Duration(seconds: 3));
      Navigator.pop(context);
      EasyLoading.dismiss();
    } else {
      if (kIsWeb) {
        html.window.location.assign(checkOutUrl);
      }
    }
  }

// Add other functions as needed (e.g., verify, restore, etc.)
}
