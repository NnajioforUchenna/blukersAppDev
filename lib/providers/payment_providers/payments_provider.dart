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

import '../../common_files/constants.dart';
import '../../data_providers/data_constants.dart';
import '../../models/payment_model/transaction_record.dart';
import '../../services/platform_check.dart';
import '../../views/common_views/please_login_dialog.dart';
import '../../views/worker/membership/mobile_view/manageSubscriptionComponents/already_premium_plus_dialog.dart';
import '../../views/worker/membership/subscription_components/countdown_waiting_page.dart';
import '../../views/worker/membership/subscription_components/payment_failed_widget.dart';
import '../../views/worker/membership/subscription_components/payment_successful_widget.dart';
import '../../views/worker/products/mobile_view/display_stripe_url_mobile.dart';

part 'in_app_purchase_payment_provider.dart';
part 'stripe_payment_provider.dart';

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
    if (kIsWeb) return "Stripe";
    if (isIOS()) return "Apple";
    if (isAndroid()) return "Google";
    return "Stripe";
  }

  Future<void> pay4Subscription(
      BuildContext context, String subscriptionType) async {
    if (appUser == null) {
      showDialog(
          context: context, builder: (context) => const PleaseLoginDialog());
      return;
    }

    String paymentPlatform = getPaymentPlatformName();

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CountDown(platform: paymentPlatform)));

    String transactionId = recordTransaction(
        transactionType: 'subscription',
        paymentPlatform: paymentPlatform,
        selectedProduct: subscriptionType,
        amount: subscriptionType == 'premium' ? 4.99 : 9.99);

    if (paymentPlatform == "Stripe") {
      getStripePayment(context, subscriptionType, transactionId);
    } else if (paymentPlatform == "Apple") {
      getApplePayment(context, subscriptionType);
    } else if (paymentPlatform == "Google") {
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
            builder: (context) => const CountDown(platform: "Stripe")));

    String transactionId = recordTransaction(
        transactionType: 'service',
        paymentPlatform: 'Stripe',
        selectedProduct: service,
        amount: service == 'foia' ? 299.99 : 99.99);

    String serviceCheckOutUrl =
        await getStripeCheckOutUrl(context, service, transactionId);

    if (serviceCheckOutUrl.isNotEmpty) {
      if (kIsWeb) {
        html.window.location.assign(serviceCheckOutUrl);
      } else {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    DisplayStripeUrlMobile(checkOutUrl: serviceCheckOutUrl)));
      }
    }
  }

  Future<void> verifyMobileStripePayment({required String checkOutUrl}) async {
    String sessionId = extractSessionId(checkOutUrl);
    if (sessionId.isNotEmpty) {
      await PaymentsDataProvider().verifyStripePayment(sessionId);
    }
  }

  String recordTransaction(
      {required String transactionType,
      required String paymentPlatform,
      required String selectedProduct,
      required double amount}) {
    TransactionRecord tr = TransactionRecord(
      userId: appUser!.uid,
      orderType: transactionType,
      platform: paymentPlatform,
      paymentProcessor: paymentPlatform,
      amount: amount,
    );
    tr.save();

    return tr.transactionId;
  }

  Future<void> upgradeSubscription(context) async {
    if (appUser?.activeSubscription?.subscriptionId ==
        'blukers_workers_premium_plus') {
      showDialog(
          context: context, builder: (context) => const AlreadyPremiumPlus());
    } else {
      pay4Subscription(context, 'premium_plus');
    }
  }

  void determineAction(
      BuildContext context, String buttonText, String subscriptionId) {
    if (buttonText == "Active") {
      showDialog(
          context: context, builder: (context) => const AlreadyPremiumPlus());
    } else if (buttonText == "Purchase") {
      String subscriptionType = subscriptionId == 'blukers_workers_premium_plus'
          ? 'premiumPlus'
          : 'premium';
      pay4Subscription(context, subscriptionType);
    } else if (buttonText == "Change Plan") {
      // Write Code to Change Plan Here
      // TODO
      // Display Cancel Subscription
    } else if (buttonText == "Upgrade") {
      pay4Subscription(context, 'premiumPlus');
    }
  }
}
