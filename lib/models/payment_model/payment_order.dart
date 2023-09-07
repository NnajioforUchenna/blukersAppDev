import 'dart:async'; // Import for Future
import 'dart:math';

import 'package:blukers/data_providers/payments_data_provider.dart';

class PaymentOrder {
  String orderId;
  String userId;
  String orderType;
  String platform;
  String paymentProcessor;
  double amount;
  String status;
  int? timeCreated;
  String? paymentProcessorId;
  String? documentId;

  PaymentOrder({
    required this.userId,
    required this.orderType,
    required this.platform,
    required this.paymentProcessor,
    required this.amount,
    this.status = 'pending',
  }) : orderId = generateOrderId(); // Initializing orderId at instance creation

  Future<void> save() async {
    // Logic to save order to Firestore
    timeCreated = DateTime.now().millisecondsSinceEpoch;
    documentId = await PaymentsDataProvider.saveOrder(this);
  }

  void updateStatus(String newStatus, String newPaymentProcessorId) {
    status = newStatus;
    paymentProcessorId = newPaymentProcessorId;

    // TODO: Add logic to call Firestore API to update the order status and paymentProcessorId
  }

  Map<String, dynamic> toMap() {
    return {
      'orderId': orderId,
      'userId': userId,
      'orderType': orderType,
      'platform': platform,
      'paymentProcessor': paymentProcessor,
      'amount': amount,
      'status': status,
      'timeCreated': timeCreated,
      'paymentProcessorId': paymentProcessorId,
      'documentId': documentId,
    };
  }

  static String generateOrderId() {
    // Made this static as it doesn't depend on an instance
    return DateTime.now().millisecondsSinceEpoch.toString() +
        Random().nextInt(999999).toString().padLeft(6, '0');
  }
}
