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

extension InAppPurchasePaymentProvider on PaymentsProvider {
  Future<void> initializeInAppPurchasePayment() async {
    print("Initializing In App Payment");

    try {
      _iap = InAppPurchase.instance;
      final bool isAvailable = await _iap.isAvailable();
      if (isAvailable) {
        print("In App Payment is available");
      } else {
        print("In App Payment is not available");
      }
    } catch (error) {
      print('IAP Error: $error');
    }
    // purchaseUpdated = _iap.purchaseStream;

    // Trying to get the products from Store
    final ProductDetailsResponse response =
        await _iap.queryProductDetails(_subscriptionIds);

    if (response.notFoundIDs.isNotEmpty) {
      // Handle missing IDs.
      print("Missing IDs: ${response.notFoundIDs}");
    }

    _subscriptions = response.productDetails;
    print("Subscriptions: $_subscriptions");
  }

  Future<void> getApplePayment(
      BuildContext context, String subscriptionType) async {
    print('Getting Apple Payment');
    // final PurchaseParam purchaseParam =
    //     PurchaseParam(productDetails: _subscriptions[0]);

    PurchaseParam purchaseParam = PurchaseParam(
      productDetails: _subscriptions[1],
    );

    await _iap.buyNonConsumable(purchaseParam: purchaseParam);

    purchaseUpdated = _iap.purchaseStream;
    purchaseUpdated.listen((purchaseDetailsList) {
      _handlePurchaseUpdates(purchaseDetailsList);
    });

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

  Future<void> appleInitialize() async {
    if (Platform.isIOS) {
      print("Initializing Apple Payment from initialize");
      final InAppPurchaseStoreKitPlatformAddition iosPlatformAddition =
          _iap.getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      await iosPlatformAddition.setDelegate(ExamplePaymentQueueDelegate());
    }
  }

  void appleDispose() {
    if (Platform.isIOS) {
      final InAppPurchaseStoreKitPlatformAddition iosPlatformAddition =
          _iap.getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      iosPlatformAddition.setDelegate(null);
    }
  }
}

/// Example implementation of the
/// [`SKPaymentQueueDelegate`](https://developer.apple.com/documentation/storekit/skpaymentqueuedelegate?language=objc).
///
/// The payment queue delegate can be implementated to provide information
/// needed to complete transactions.s
class ExamplePaymentQueueDelegate implements SKPaymentQueueDelegateWrapper {
  @override
  bool shouldContinueTransaction(
      SKPaymentTransactionWrapper transaction, SKStorefrontWrapper storefront) {
    return true;
  }

  @override
  bool shouldShowPriceConsent() {
    return false;
  }
}
