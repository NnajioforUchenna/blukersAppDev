part of '../payments_provider.dart';

extension StripePaymentProvider on PaymentsProvider {
  Future<void> initializeStripe() async {
    getServicesKeys();
    stripeData = await fetchStripeData();
    if (appUser != null && appUser!.uid.isNotEmpty) {
      status = checkSubscriptionStatus(appUser!.uid, stripeData);
    }
  }

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

  Future<String> getCheckOutUrl(
      priceId, successUrl, failedUrl, productName) async {
    Map<String, dynamic> metadata = {
      "user_email": appUser!.email,
      "user_id": appUser!.uid,
      "product_id": productName,
      "payment_type": "subscription"
    };

    print('successUrl: $successUrl');
    print('failedUrl: $failedUrl');

    successUrl = successUrl + "/success?session_id={CHECKOUT_SESSION_ID}";
    failedUrl = failedUrl + "/failed?session_id={CHECKOUT_SESSION_ID}";

    FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentReference docRef = await firestore
        .collection("AppUsers")
        .doc(appUser!.uid)
        .collection("checkout_sessions")
        .add({
      "price": priceId,
      "success_url": successUrl,
      "cancel_url": failedUrl,
      "metadata": metadata,
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
      print("Attempt: $attempts");
      attempts++;
      if (attempts < maxAttempts) {
        await Future.delayed(
            delayBetweenAttempts); // Wait before the next attempt
      }
    }

    return 'error';
  }

  Future<void> getStripePayment(
    BuildContext context,
    String subscriptionType,
  ) async {
    String priceId = "";
    String productName = "";
    if (subscriptionType == "premium") {
      priceId = stripeData.employeePremiumPriceId;
      productName = 'blukers_workers_premium';
    } else {
      priceId = stripeData.employeePremiumPlusPriceId;
      productName = 'blukers_workers_premium_plus';
    }

    String urlEx = Uri.base.toString();
    String baseUrl = Uri.parse(urlEx).removeFragment().toString();
    String successUrl = baseUrl + 'paymentSuccess';
    String failedUrl = baseUrl + 'paymentFailed';

    String checkOutUrl =
        await getCheckOutUrl(priceId, successUrl, failedUrl, productName);

    if (checkOutUrl == 'error') {
      notifyUserError(context);
    } else {
      if (kIsWeb) {
        html.window.location.assign(checkOutUrl);
      }
    }
  }

  Future<void> getServicesKeys() async {
    const List<String> ServicesDocIds = ['foia', 'employmentVerification'];
    for (String docId in ServicesDocIds) {
      DocumentSnapshot doc = await stripeDataDB.doc(docId).get();
      if (doc.exists) {
        Map<String, dynamic> currentData = doc.data() as Map<String, dynamic>;
        servicesKey[docId] = currentData?['key'] ?? '';
      }
    }
  }

  // Future<void> setServiceKeys() async {
  //   // Set 'foia' key
  //   await stripeDataDB.doc('foia').set({
  //     'key': 'price_1Nld4yAwqpCFthEvVUxE4AmP',
  //   });
  //
  //   // Set 'employmentVerification' key
  //   await stripeDataDB.doc('employmentVerification').set({
  //     'key': 'price_1Nld6tAwqpCFthEv5Gl6Ixo4',
  //   });
  // }

  // Future<String> getStripeCheckOutUrl(
  //     BuildContext context, String service) async {
  //   String priceId = servicesKey[service] ?? '';
  //   if (priceId.isEmpty) {
  //     notifyUserError(context);
  //     return '';
  //   }
  //   String urlEx = Uri.base.toString();
  //   String baseUrl = Uri.parse(urlEx).removeFragment().toString();
  //   String successUrl = baseUrl + 'paymentSuccess';
  //   String failedUrl = baseUrl + 'paymentFailed';
  //
  //   String checkOutUrl =
  //       await getServiceCheckOutUrl(priceId, successUrl, failedUrl);
  //
  //   if (checkOutUrl == 'error') {
  //     notifyUserError(context);
  //   } else {
  //     return checkOutUrl;
  //   }
  //
  //   return '';
  // }

  Future<void> notifyUserError(BuildContext context) async {
    EasyLoading.show(
      status: 'An Error Occurred While Getting Stripe Payment...',
      maskType: EasyLoadingMaskType.black,
    );

    // Delay for 5 seconds
    await Future.delayed(const Duration(seconds: 3));
    Navigator.pop(context);
    EasyLoading.dismiss();
  }

  // getServiceCheckOutUrl(
  //     String priceId, String successUrl, String failedUrl) async {
  //   print("Getting Checkout Url");
  //   print(priceId);
  //
  //   // Map<String, dynamic> metadata = {
  //   //   "user_email": appUser!.email,
  //   //   "user_id": appUser!.uid,
  //   //   "product_id": service,
  //   //   "payment_type": "subscription"
  //   // };
  //
  //   FirebaseFirestore firestore = FirebaseFirestore.instance;
  //   DocumentReference docRef = await firestore
  //       .collection("AppUsers")
  //       .doc(appUser!.uid)
  //       .collection("checkout_sessions")
  //       .add({
  //     "price": priceId,
  //     "quantity": 1,
  //     "mode": "payment",
  //     "success_url": successUrl,
  //     "cancel_url": failedUrl,
  //     // "metadata": metadata,
  //   });
  //
  //   int attempts = 0;
  //   const maxAttempts = 3;
  //   const delayBetweenAttempts = Duration(seconds: 5); // Adjust as needed
  //
  //   while (attempts < maxAttempts) {
  //     DocumentSnapshot snapshot = await docRef.snapshots().first;
  //
  //     if (snapshot.exists) {
  //       Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
  //       if (data != null && data['url'] != null) {
  //         String checkOutUrl = data['url'];
  //         print(checkOutUrl);
  //         return checkOutUrl;
  //       }
  //     }
  //     print("Attempt: $attempts");
  //     attempts++;
  //     if (attempts < maxAttempts) {
  //       await Future.delayed(
  //           delayBetweenAttempts); // Wait before the next attempt
  //     }
  //   }
  //
  //   return 'error';
  // }

  Future<String> getStripeCheckOutUrl(
      BuildContext context, String service) async {
    String productName = 'FOIA Request';
    double amount = 100.0;

    if (service == 'foia') {
      productName = 'FOIA Request';
      amount = 299.99;
    } else if (service == 'employmentVerification') {
      productName = 'Employment Verification';
      amount = 99.99;
    }

    if (productName.isEmpty || amount <= 0) {
      notifyUserError(context);
      return '';
    }

    String successUrl = '';
    String failedUrl = '';

    if (kIsWeb) {
      final baseUrl = Uri.base.removeFragment().toString();
      successUrl = baseUrl + 'paymentSuccess';
      failedUrl = baseUrl + 'paymentFailed';
    } else {
      successUrl = 'https://success.com';
      failedUrl = 'https://www.cancel.com';
    }

    Map<String, dynamic> metadata = {
      "user_email": appUser!.email,
      "user_id": appUser!.uid,
      "product_id": service,
      "payment_type": "service"
    };

    final response = await _makeStripeRequest(
        productName, amount, successUrl, failedUrl, metadata);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      if (jsonResponse.containsKey('checkout_url')) {
        return jsonResponse['checkout_url'];
      }
    }

    notifyUserError(context);
    return '';
  }

  Future<http.Response> _makeStripeRequest(String productName, double amount,
      String successUrl, String failedUrl, Map<String, dynamic> metadata) {
    return http.post(
      Uri.parse('$baseUrlAppEngineFunctions/payments/one-time-checkout'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'product_name': productName,
        'amount': amount,
        'success_url': successUrl,
        'cancel_url': failedUrl,
        "user_email": appUser!.email,
        "metadata": metadata,
      }),
    );
  }

  Future<void> verifyPayment(UrlInfo urlInfo, String from) async {
    if (urlInfo.sessionId != null) {
      Map<String, dynamic> result =
          await PaymentsDataProvider().verifyStripePayment(urlInfo.sessionId!);
      print(result);
    }
  }
}
