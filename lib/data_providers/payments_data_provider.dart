import 'dart:convert';

import 'package:blukers/models/payment_model/transaction_record.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/billing_client_wrappers.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'package:in_app_purchase_storekit/store_kit_wrappers.dart';

import '../services/platform_check.dart';
import 'data_constants.dart';

final db = FirebaseFirestore.instance;

class PaymentsDataProvider {
  static Future<String> saveOrder(TransactionRecord pOrder) async {
    final ordCol = db.collection(ordersCollection);
    DocumentReference documentRef = ordCol.doc();
    String newDocumentId = documentRef.id;
    pOrder.documentId = newDocumentId;
    DocumentReference orderDocRef = ordCol.doc(pOrder.userId);
    await orderDocRef
        .set({newDocumentId: pOrder.toMap()}, SetOptions(merge: true));
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
    String productID = purchase.productID;
    if (uid != null) {
      db.collection('AppUsers').doc(uid).set({
        'isSubscriptionActive': true,
        'activeSubscriptionId': productID,
      }, SetOptions(merge: true));
    }
  }
}
