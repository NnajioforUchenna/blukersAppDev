part of '../payments_provider.dart';

extension InAppPurchasePaymentProvider on PaymentsProvider {
  /// Initializes the in-app purchase payment system.
  Future<void> initializeInAppPurchasePayment() async {
    // 1. In-App Purchase Initialization
    _iap = InAppPurchase.instance;

    // 2. Checking In-App Purchase Availability
    final bool isAvailable = await _iap.isAvailable();

    // 3. Handling Available In-App Purchases
    if (isAvailable) {
      // 4. Listening to Purchase Updates
      purchaseUpdated = _iap.purchaseStream;
      _subscription = purchaseUpdated.listen((purchaseDetailsList) {
        _handlePurchaseUpdates(purchaseDetailsList);
      }, onDone: () {
        _subscription.cancel();
      }, onError: (error) {
        // handle error here.
      });

      // 5. Querying Product Details
      final ProductDetailsResponse response =
          await _iap.queryProductDetails(_subscriptionIds);

      // 6. Handling Missing Product IDs
      if (response.notFoundIDs.isNotEmpty) {
        print("Missing IDs: ${response.notFoundIDs}");
      }

      // 7. Storing Product Details
      _listSubscriptionDetails = response.productDetails;
      print("Subscriptions: $_listSubscriptionDetails");
    }
  }

  Future<void> getApplePayment(
      BuildContext context, String subscriptionType) async {
    // Set Current Context For Navigation
    currentContext = context;

    // Determine subscription type
    int indexSubType = subscriptionType == 'premium' ? 0 : 1;
    if (_listSubscriptionDetails.length > 1) {
      PurchaseParam purchaseParam = PurchaseParam(
        productDetails: _listSubscriptionDetails[indexSubType],
      );
      await _iap.buyNonConsumable(purchaseParam: purchaseParam);
    }
  }

  getGooglePayment(BuildContext context, String subscriptionType) async {
    // Set Current Context For Navigation
    currentContext = context;

    // Determine subscription type
    int indexSubType = subscriptionType == 'premium' ? 0 : 2;

    if (_listSubscriptionDetails.length > 3) {
      PurchaseParam purchaseParam = PurchaseParam(
        productDetails: _listSubscriptionDetails[indexSubType],
      );

      await _iap.buyNonConsumable(purchaseParam: purchaseParam);
    } else {
      print('No Google Subscription Available');
    }
  }

  void _handlePurchaseUpdates(List<PurchaseDetails> purchaseDetailsList) {
    for (var purchase in purchaseDetailsList) {
      if (purchase.status == PurchaseStatus.pending) {
        // Notify the user or show a loading spinner.
        handlePendingTransaction(purchase);
      } else if (purchase.status == PurchaseStatus.error) {
        // Notify the user about the error.
        handleErrorTransaction(purchase.error!);
        _iap.completePurchase(purchase);
      } else if (purchase.status == PurchaseStatus.purchased ||
          purchase.status == PurchaseStatus.restored) {
        // Verify the purchase (preferably on your server).
        // Then, deliver the product or unlock the feature.
        verifyAndDeliverProduct(purchase);
        _iap.completePurchase(purchase);
      }
      if (purchase.pendingCompletePurchase) {
        _iap.completePurchase(purchase);
      }
    }
  }

  Future<void> appleInitialize() async {
    if (isIOS()) {
      final InAppPurchaseStoreKitPlatformAddition iosPlatformAddition =
          _iap.getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      await iosPlatformAddition.setDelegate(ExamplePaymentQueueDelegate());
    }
  }

  void appleDispose() {
    if (isIOS()) {
      final InAppPurchaseStoreKitPlatformAddition iosPlatformAddition =
          _iap.getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      iosPlatformAddition.setDelegate(null);
    }
  }

  void handleErrorTransaction(IAPError error) {
    // 1. Extract error details.
    final String errorCode = error.code;
    final String errorMessage = error.message;

    // 2. Log the error for debugging and analysis.
    print('Error Code: $errorCode');
    print('Error Message: $errorMessage');

    // 3. Navigate the user to the paymentFailed page.
    if (currentContext != null) {
      Navigator.push(
        currentContext!,
        MaterialPageRoute(
          builder: (context) => PaymentFailedWidget(
            urlInfo: UrlInfo.empty(),
          ),
        ),
      );
    }
  }

  void verifyAndDeliverProduct(PurchaseDetails purchase) {
    // Updates Records in Firestore
    updateSubscriptionPaymentRecords(purchase);

    if (currentContext != null) {
      Navigator.push(
        currentContext!,
        MaterialPageRoute(
          builder: (context) => PaymentSuccessfulWidget(
            urlInfo: UrlInfo.empty(),
          ),
        ),
      );
    }
  }

  void handlePendingTransaction(PurchaseDetails purchase) {
    // 1. Check the specifics of the purchase if necessary.
    final String productId = purchase.productID;

    // 2. Log the transaction for debugging and analysis.
    print('Pending transaction for product ID: $productId');

    if (currentContext != null) {
      Navigator.push(
        currentContext!,
        MaterialPageRoute(
            builder: (context) => CountDown(
                  platform: productId,
                )),
      );
    }
  }

  void updateSubscriptionPaymentRecords(PurchaseDetails purchase) {
    // 1. Update User's Subscription Status
    PaymentsDataProvider.updateUserSubscriptionStatus(appUser?.uid, purchase);

    // 2. Update UserPaymentDetails
    // 3. Update UserSubscriptionDetails

    // 4. Update Payment Plaform Details
    PaymentsDataProvider.updatePlatformDetails(purchase);

    // 5.Update Order Records
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
