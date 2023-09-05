part of '../payments_provider.dart';

// // In iOS there is an error when you close or cancel the in-app subscription
// // purchase and then you try purchasing it again.
// // ERROR:
// // Unhandled Exception: PlatformException(storekit_duplicate_product_object,
// // There is a pending transaction for the same product identifier. Please
// // either wait for it to be finished or finish it manually using
// // `completePurchase` to avoid edge cases., {applicationUsername: null,
// // requestData: null, quantity: 1, productIdentifier: blukers_workers_premium,
// // simulatesAskToBuyInSandbox: false, paymentDiscount: null}, null)
// // A Solution that might work:
// // Complete all pending purchases to avoid errors
//   for (var purchaseDetails in purchaseDetailsList) {
//     if (purchaseDetails.pendingCompletePurchase) {
//       await _iap.completePurchase(purchaseDetails);
//     }
//   }

extension ApplePaymentProvider on PaymentsProvider {
  Future<void> initializeApplePayment() async {
    print("Initializing Apple Payment");
    _iap = InAppPurchase.instance;
    purchaseUpdated = _iap.purchaseStream;

    final ProductDetailsResponse response =
        await _iap.queryProductDetails(_subscriptionIds);

    if (response.notFoundIDs.isNotEmpty) {
      // Handle missing IDs.
      print("Missing IDs: ${response.notFoundIDs}");
    }

    _subscriptions = response.productDetails;
    print("Subscriptions: $_subscriptions");
  }

  void getApplePayment(BuildContext context, String subscriptionType) {
    final PurchaseParam purchaseParam =
        PurchaseParam(productDetails: _subscriptions[0]);
    _iap.buyNonConsumable(purchaseParam: purchaseParam);

    _initializePurchaseUpdate();
  }

  void _initializePurchaseUpdate() {
    _iap.purchaseStream.listen((purchaseDetailsList) {
      _handlePurchaseUpdates(purchaseDetailsList);
    }, onError: (error) {
      // Handle errors here.
    });
  }

  void _handlePurchaseUpdates(List<PurchaseDetails> purchaseDetailsList) async {
    for (var purchaseDetails in purchaseDetailsList) {
      // Handle your purchase logic here - for example, unlocking content, updating the UI, etc.

      if (purchaseDetails.status == PurchaseStatus.purchased) {
        // Complete the purchase, this is important especially on Android.
        _iap.completePurchase(purchaseDetails);
      }

      // Handle other purchase statuses if needed, such as:
      // PurchaseStatus.error, PurchaseStatus.pending, etc.
    }
  }
}
