import 'dart:convert';
import 'dart:io';

import 'package:blukers/models/app_user.dart';
import 'package:blukers/services/stripe_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'package:in_app_purchase_storekit/store_kit_wrappers.dart';
import 'package:universal_html/html.dart' as html;

import '../models/subscription_model.dart';
import '../views/membership/subscription_components/countdown_waiting_page_pulse.dart';
import '../views/services/mobile_view/display_stripe_url_mobile.dart';

part 'payment_providers/in_app_purchase_payment_provider.dart';
part 'payment_providers/stripe_payment_provider.dart';

// Firestore instance
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference stripeDataDB = _firestore.collection('stripe_data');

class PaymentsProvider with ChangeNotifier {
  AppUser? appUser;

  // Stripe Services priceId
  Map<String, String> servicesKey = {};

  // In-app Purchase parameters
  late final InAppPurchase _iap;
  late final Stream<List<PurchaseDetails>> purchaseUpdated;
  final Set<String> _subscriptionIds = {
    'blukers_workers_premium',
    'blukers_workers_premium_plus'
  };
  List<ProductDetails> _subscriptions = [];

  late Stream<SubscriptionStatus> status;
  late StripeData stripeData;
  bool isActiveMember = false;

  // You'll initialize your payment SDKs here
  PaymentsProvider() {
    if (kIsWeb) {
      // Initialize Stripe
      initializeStripe();
    } else {
      initializeInAppPurchasePayment();
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
    QuerySnapshot qs,
    StripeData stripeData,
  ) {
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
    BuildContext context,
    String subscriptionType,
  ) async {
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
      // In-app Purchase Code for Apple
      getApplePayment(context, subscriptionType);
    } else if (paymentPlatform == "Google") {
      // In-app Purchase Code for Google
      getApplePayment(context, subscriptionType);
    }
  }

  Future<void> pay4Services(BuildContext context, String service) async {
    print("pay4Services");
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => const CountDown(
                platform: "Stripe",
              )),
    );

    String serviceCheckOutUrl = await getStripeCheckOutUrl(context, service);
    print('This is what i got for Service CheckOut Url');
    print('This is the CheckOutURL $serviceCheckOutUrl');

    if (serviceCheckOutUrl.isNotEmpty) {
      if (kIsWeb) {
        html.window.location.assign(serviceCheckOutUrl);
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DisplayStripeUrlMobile(
                    checkOutUrl: serviceCheckOutUrl,
                  )),
        );
      }
    }
  }
}
