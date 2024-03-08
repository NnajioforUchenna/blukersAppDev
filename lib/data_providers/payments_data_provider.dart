import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/billing_client_wrappers.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'package:in_app_purchase_storekit/store_kit_wrappers.dart';

import '../common_files/constants.dart';
import '../models/app_user.dart';
import '../models/payment_model/subscription_model.dart';
import '../models/payment_model/transaction_record.dart';
import '../services/platform_check.dart';
import 'data_constants.dart';

final db = FirebaseFirestore.instance;

class PaymentsDataProvider {
  static Future<String> saveOrder(TransactionRecord pOrder) async {
    // Save document to 'Transactions' collection
    final transactionsCol = db.collection(transactionsCollection);
    DocumentReference transactionDocRef = transactionsCol.doc();
    String newTransactionDocId = transactionDocRef.id;
    pOrder.documentId = newTransactionDocId;
    DocumentReference orderDocRef = transactionsCol.doc(pOrder.documentId);
    await orderDocRef.set(pOrder.toMap(), SetOptions(merge: true));

    // Save document to 'TransactionsByUID' collection
    final orderByUIDCol = db.collection(transactionsByUIDCollection);
    // DocumentReference documentByUIDRef = orderByUIDCol.doc();
    // String newTransactionByUIDDocId = documentByUIDRef.id;
    // pOrder.documentId = newTransactionByUIDDocId;
    DocumentReference orderDocByUIDRef = orderByUIDCol.doc(pOrder.userId);
    await orderDocByUIDRef
        .set({newTransactionDocId: pOrder.toMap()}, SetOptions(merge: true));

    return newTransactionDocId;
  }

  static updatePlatformDetails(PurchaseDetails purchaseDetails) {
    String platform = isIOS() ? appleCollection : googleCollection;
    final platformCol = db.collection(platform);
    Map<String, dynamic> purchaseWrapper = {};

    if (purchaseDetails is GooglePlayPurchaseDetails) {
      PurchaseWrapper billingClientPurchase =
          (purchaseDetails).billingClientPurchase;
      purchaseWrapper = {
        'developerPayload': billingClientPurchase.developerPayload,
        'isAcknowledged': billingClientPurchase.isAcknowledged,
        'isAutoRenewing': billingClientPurchase.isAutoRenewing,
        'obfuscatedAccountId': billingClientPurchase.obfuscatedAccountId,
        'obfuscatedProfileId': billingClientPurchase.obfuscatedProfileId,
        'orderId': billingClientPurchase.orderId,
        'originalJson': billingClientPurchase.originalJson,
        'packageName': billingClientPurchase.packageName,
        'purchaseTime': billingClientPurchase.purchaseTime,
        'purchaseToken': billingClientPurchase.purchaseToken,
        'signature': billingClientPurchase.signature,
      };
    } else if (purchaseDetails is AppStorePurchaseDetails) {
      SKPaymentTransactionWrapper skProduct =
          (purchaseDetails).skPaymentTransaction;
      purchaseWrapper = {
        'transactionState': skProduct.transactionState,
        'transactionTimeStamp': skProduct.transactionTimeStamp,
        'transactionIdentifier': skProduct.transactionIdentifier,
        'payment': skProduct.payment,
        'error': skProduct.error,
        'originalTransaction': skProduct.originalTransaction,
      };
    }

    print(purchaseWrapper);
    if (purchaseWrapper.isNotEmpty) {
      platformCol
          .doc(purchaseDetails.purchaseID)
          .set({"Purchase Wrapper": purchaseWrapper}, SetOptions(merge: true));
    } else {
      print('Unsupported purchase details provided.');
    }
  }

  Future<Map<String, dynamic>> verifyStripePayment(
      String checkoutSessionId) async {
    String apiUrl = '$baseUrlAppEngineFunctions/payments/verify-stripe-payment';

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'checkout_session_id': checkoutSessionId,
      }),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print('Failed to verify payment.');
      return {};
    }
  }

  static void updateUserSubscriptionStatus(
      String? uid, PurchaseDetails purchase) {
    // Create ActiveSubscription object from purchase details
    print('purchase.productID: ${purchase.productID}');

    SubscriptionPlan activeSubscription = SubscriptionPlan(
      subscribeDate: DateTime.now().millisecondsSinceEpoch,
      // add 30 days to the current date
      renewDate: DateTime.now().millisecondsSinceEpoch + 2592000000,
      subscriptionId: purchase.productID,
      subscriptionName: ProductNames[purchase.productID] ?? '',
      amountPaid: ProductPrices[purchase.productID] ?? 0.0,
      paymentPlatform: isIOS() ? 'Apple' : 'Google',
    );

    print(activeSubscription.toMap().toString());

    if (uid != null) {
      db.collection('AppUsers').doc(uid).set({
        'isSubscriptionActive': true,
        'activeSubscription': activeSubscription.toMap(),
      }, SetOptions(merge: true));
    }
  }

  verifyStripePaymentOnFirebase(String transactionId, String userId) async {
    DocumentSnapshot? subscription =
        await getSubscriptionByTransactionId(userId, transactionId);
    if (subscription != null) {
      Map<String, dynamic> subscriptionData =
          subscription.data() as Map<String, dynamic>;
      Map<String, dynamic> metadata = subscriptionData['metadata'];
      String? productId = metadata['product_id'];
      String productName = ProductNames[productId] ?? '';

      SubscriptionPlan activeSubscription = SubscriptionPlan(
        subscribeDate: DateTime.now().millisecondsSinceEpoch,
        // add 30 days to the current date
        renewDate: DateTime.now().millisecondsSinceEpoch + 2592000000,
        subscriptionId: productId ?? '',
        subscriptionName: productName,
        amountPaid: ProductPrices[productId] ?? 0.0,
        paymentPlatform: 'Stripe',
      );

      print(activeSubscription.toMap().toString());

      db.collection('AppUsers').doc(userId).set({
        'isSubscriptionActive': true,
        'activeSubscription': activeSubscription.toMap(),
      }, SetOptions(merge: true));
    }
  }

  static Future<DocumentSnapshot?> getSubscriptionByTransactionId(
      String userId, String transactionId) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      QuerySnapshot querySnapshot = await firestore
          .collection("AppUsers")
          .doc(userId)
          .collection("subscriptions")
          .where("metadata.transactionId", isEqualTo: transactionId)
          .get();

      // Check if a matching document is found.
      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.first; // Return the first matching document
      }

      return null; // Return null if no matching document is found.
    } catch (error) {
      print("Error fetching subscription: $error");
      return null;
    }
  }

  void cancelSubscription(AppUser appUser, String paymentPlatform) {
    //   1. Cancel Users Subscription
    int subscriptionRenewDate = appUser.activeSubscription!.renewDate;
    SubscriptionPlan defferedSubscription = SubscriptionPlan(
      subscribeDate: subscriptionRenewDate,
      renewDate: subscriptionRenewDate + 2592000000,
      subscriptionId: 'basic',
      subscriptionName: 'Basic',
      amountPaid: 0.0,
      paymentPlatform: paymentPlatform,
    );

    db.collection('AppUsers').doc(appUser.uid).set({
      'deferredSubscription': defferedSubscription.toMap(),
    }, SetOptions(merge: true));

    //   2. Record Deffered Payments in a collection called DefferedPayments
    db.collection('DefferedPayments').doc(appUser.uid).set({
      'deferredSubscription': defferedSubscription.toMap(),
    }, SetOptions(merge: true));
  }

  void removeDefferedPayment(AppUser appUser) {
    db.collection('AppUsers').doc(appUser.uid).set({
      'deferredSubscription': null,
    }, SetOptions(merge: true));

    db.collection('DefferedPayments').doc(appUser.uid).delete();
  }
}
