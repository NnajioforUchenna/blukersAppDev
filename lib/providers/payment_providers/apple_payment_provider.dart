part of '../payments_provider.dart';

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

  void _handlePurchaseUpdates(List<PurchaseDetails> purchaseDetailsList) {
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
