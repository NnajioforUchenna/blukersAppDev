// This file is used by firebase extension stripe firebase, when a user
// registers using Firebase authentication, this file contents will be called
// automatically by the extension, and will merge into the user document the
// next 2 fields: stripeId and stripeLink. In this app, the users collection is
// AppUsers
// But we also use this file to get our stripe product memberships data.

import 'package:cloud_firestore/cloud_firestore.dart';

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
