class SubscriptionPlan {
  final int subscribeDate;
  final int renewDate;
  final String subscriptionId;
  final String subscriptionName;
  final double amountPaid;
  final String paymentPlatform;

  SubscriptionPlan({
    required this.subscribeDate,
    required this.renewDate,
    required this.subscriptionId,
    required this.subscriptionName,
    required this.amountPaid,
    required this.paymentPlatform,
  });

  // Convert SubscriptionPlan object into a map
  Map<String, dynamic> toMap() {
    return {
      'subscribeDate': subscribeDate,
      'renewDate': renewDate,
      'subscriptionId': subscriptionId,
      'subscriptionName': subscriptionName,
      'amountPaid': amountPaid,
      'paymentPlatform': paymentPlatform,
    };
  }

  // Create SubscriptionPlan object from a map
  static SubscriptionPlan fromMap(Map<String, dynamic> map) {
    try {
      return SubscriptionPlan(
        subscribeDate: map['subscribeDate'],
        renewDate: map['renewDate'],
        subscriptionId: map['subscriptionId'],
        subscriptionName: map['subscriptionName'],
        amountPaid: map['amountPaid'],
        paymentPlatform: map['paymentPlatform'],
      );
    } catch (e) {
      // Log the error or handle it as necessary
      print('Error converting map to SubscriptionPlan: $e');
      // Optionally, return a default object or null
      return SubscriptionPlan(
        subscribeDate: 0,
        renewDate: 0,
        subscriptionId: '',
        subscriptionName: '',
        amountPaid: 0.0,
        paymentPlatform: '',
      );
    }
  }

  @override
  String toString() {
    return 'SubscriptionPlan(subscribeDate: $subscribeDate, renewDate: $renewDate, subscriptionId: $subscriptionId, subscriptionName: $subscriptionName, amountPaid: $amountPaid, paymentPlatform: $paymentPlatform)';
  }
}
