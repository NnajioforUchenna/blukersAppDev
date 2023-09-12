// This file is used by firebase extension stripe firebase, when a user
// registers using Firebase authentication, this file contents will be called
// automatically by the extension, and will merge into the user document the
// next 2 fields: stripeId and stripeLink. In this app, the users collection is
// AppUsers
// But we also use this file to get our stripe product memberships data.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

Future<StripeData> fetchStripeData() async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // dev: 1t9JfNnPqitkZFHkTL8x
  // prod: Zh9frPRhBEPlSnlxdJyI
  var ds = await firestore
      .collection('stripe_data')
      .doc('1t9JfNnPqitkZFHkTL8x')
      .get();

  return StripeData(
    employeePremiumPriceId: ds.get('employeePremiumPriceId'),
    employeePremiumPlusPriceId: ds.get('employeePremiumPlusPriceId'),
    employerPremiumPriceId: ds.get('employerPremiumPriceId'),
  );
}

Future<DocumentReference> setCheckoutSession(String uid, String priceId) async {
  EasyLoading.show(
    status: 'Creating checkout session...',
    maskType: EasyLoadingMaskType.black,
  );
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  DocumentReference docRef = await firestore
      .collection("AppUsers")
      .doc(uid)
      .collection("checkout_sessions")
      .add({
    "price": priceId,
    "success_url": kIsWeb ? "http://localhost:50246/" : "https://success.com",
    "cancel_url": kIsWeb ? "http://localhost:50246/" : "https://cancel.com",
  });

  EasyLoading.dismiss();
  return docRef;
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
      return SubscriptionStatus(
          status: status, activePriceId: currentPriceId, subIsActive: true);
    }
  }
  return SubscriptionStatus(status: "", activePriceId: "", subIsActive: false);
}

getCustomerPortalUrl() async {
  HttpsCallable callable = FirebaseFunctions.instance
      .httpsCallable('ext-firestore-stripe-payments-createPortalLink');

  EasyLoading.show(
    status: 'Creating Your Portal...',
    maskType: EasyLoadingMaskType.black,
  );

  HttpsCallableResult result = await callable.call(
      {'returnUrl': kIsWeb ? 'http://localhost:50246/' : "https://cancel.com"});

  EasyLoading.dismiss();

  print(result.data);
  if (result.data != null) {
    var url = result.data["url"];
    return url;
  }
}

class StripeData {
  String employeePremiumPriceId;
  String employeePremiumPlusPriceId;
  String employerPremiumPriceId;
  StripeData({
    required this.employeePremiumPriceId,
    required this.employeePremiumPlusPriceId,
    required this.employerPremiumPriceId,
  });
}

class SubscriptionStatus {
  bool subIsActive;
  String status;
  String activePriceId;
  SubscriptionStatus(
      {required this.status,
      required this.activePriceId,
      required this.subIsActive});
}
