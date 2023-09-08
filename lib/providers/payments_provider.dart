import 'dart:async';
import 'dart:convert';

import 'package:blukers/data_providers/payments_data_provider.dart';
import 'package:blukers/models/app_user.dart';
import 'package:blukers/models/payment_model/url_info.dart';
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

import '../common_files/constants.dart';
import '../data_providers/data_constants.dart';
import '../models/payment_model/payment_order.dart';
import '../models/subscription_model.dart';
import '../services/platform_check.dart';
import '../views/common_views/please_login_dialog.dart';
import '../views/membership/subscription_components/countdown_waiting_page_pulse.dart';
import '../views/membership/subscription_components/payment_failed_widget.dart';
import '../views/membership/subscription_components/payment_successful_widget.dart';
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
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  List<ProductDetails> _listSubscriptionDetails = [];
  BuildContext? currentContext;

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
      if (isIOS()) {
        // In-app Purchase Code
      } else if (isAndroid()) {
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
      if (isIOS()) {
        return "Apple";
      } else if (isAndroid()) {
        return "Google";
      }
    }
    return "Stripe";
  }

  Future<void> pay4Subscription(
    BuildContext context,
    String subscriptionType,
  ) async {
    if (appUser == null) {
      showDialog(
          context: context, builder: (context) => const PleaseLoginDialog());
      return;
    }

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
    // Create a new Payment Order
    PaymentOrder pOrder = PaymentOrder(
      userId: appUser!.uid,
      orderType: 'subscription',
      platform: paymentPlatform,
      paymentProcessor: paymentPlatform,
      amount: subscriptionType == 'premium' ? 4.99 : 9.99,
    );
    // Save the Payment Order to Firestore
    pOrder.save();

    // connect the payment platform
    if (paymentPlatform == "Stripe") {
      getStripePayment(context, subscriptionType);
    } else if (paymentPlatform == "Apple") {
      // In-app Purchase Code for Apple
      getApplePayment(context, subscriptionType);
    } else if (paymentPlatform == "Google") {
      // In-app Purchase Code for Google
      getGooglePayment(context, subscriptionType);
    }
  }

  Future<void> pay4Services(BuildContext context, String service) async {
    if (appUser == null) {
      showDialog(
          context: context, builder: (context) => const PleaseLoginDialog());
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => const CountDown(
                platform: "Stripe",
              )),
    );

    // Create a new Payment Order
    PaymentOrder pOrder = PaymentOrder(
        userId: appUser!.uid,
        orderType: 'service',
        platform: 'Stripe',
        paymentProcessor: 'Stripe',
        amount: service == 'foia' ? 299.99 : 99.99);
    // Save the Payment Order to Firestore
    pOrder.save();

    String serviceCheckOutUrl = await getStripeCheckOutUrl(context, service);

    print(serviceCheckOutUrl);

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

  Future<void> verifyMobileStripePayment({required String checkOutUrl}) async {
    // get sessionID from checkOutUrl
    String sessionId = extractSessionId(checkOutUrl);
    print(sessionId);
    if (sessionId.isEmpty) {
      print("Session ID is empty");
      return;
    }
    Map<String, dynamic> result =
        await PaymentsDataProvider().verifyStripePayment(sessionId);
    print(result);
  }
}
