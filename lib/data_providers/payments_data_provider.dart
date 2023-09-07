import 'package:blukers/models/payment_model/payment_order.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/billing_client_wrappers.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'package:in_app_purchase_storekit/store_kit_wrappers.dart';

import '../services/platform_check.dart';
import 'data_constants.dart';

final db = FirebaseFirestore.instance;

class PaymentsDataProvider {
  static Future<String> saveOrder(PaymentOrder pOrder) async {
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
}
