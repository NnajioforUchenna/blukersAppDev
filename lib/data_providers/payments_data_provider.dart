import 'dart:convert';

import 'package:blukers/models/payment_model/transaction_record.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/billing_client_wrappers.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'package:in_app_purchase_storekit/store_kit_wrappers.dart';

import '../common_files/constants.dart';
import '../models/payment_model/active_subscription.dart';
import '../services/platform_check.dart';
import 'data_constants.dart';

final db = FirebaseFirestore.instance;

class PaymentsDataProvider {
  static Future<String> saveOrder(TransactionRecord pOrder) async {
    // Save document to 'Transactions' collection
    final ordCol = db.collection(transactionsCollection);
    DocumentReference documentRef = ordCol.doc();
    String newDocumentId = documentRef.id;
    pOrder.documentId = newDocumentId;
    DocumentReference orderDocRef = ordCol.doc(pOrder.documentId);
    await orderDocRef.set(pOrder.toMap(), SetOptions(merge: true));

    // Save document to 'TransactionsByUID' collection
    final ordByUIDCol = db.collection(transactionsByUIDCollection);
    DocumentReference documentByUIDRef = ordByUIDCol.doc();
    String newDocumentByUIDId = documentByUIDRef.id;
    pOrder.documentId = newDocumentByUIDId;
    DocumentReference orderDocByUIDRef = ordByUIDCol.doc(pOrder.userId);
    await orderDocByUIDRef
        .set({newDocumentByUIDId: pOrder.toMap()}, SetOptions(merge: true));

    return newDocumentId;
  }

  static updatePlatformDetails(PurchaseDetails purchaseDetails) {
    String platform = isIOS() ? appleCollection : googleCollection;
    final platformCol = db.collection(platform);
    Map<String, dynamic> purchaseWrapper = {};

    if (purchaseDetails is GooglePlayPurchaseDetails) {
      PurchaseWrapper billingClientPurchase =
          (purchaseDetails as GooglePlayPurchaseDetails).billingClientPurchase;
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
          (purchaseDetails as AppStorePurchaseDetails).skPaymentTransaction;
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
    const String apiUrl =
        baseUrlAppEngineFunctions + '/payments/verify-stripe-payment';

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

    ActiveSubscription activeSubscription = ActiveSubscription(
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

      ActiveSubscription activeSubscription = ActiveSubscription(
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
}
