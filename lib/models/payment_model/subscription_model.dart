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

  // Convert ActiveSubscription object into a map
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

  // Create ActiveSubscription object from a map
  static SubscriptionPlan fromMap(Map<String, dynamic> map) {
    return SubscriptionPlan(
      subscribeDate: map['subscribeDate'],
      renewDate: map['renewDate'],
      subscriptionId: map['subscriptionId'],
      subscriptionName: map['subscriptionName'],
      amountPaid: map['amountPaid'],
      paymentPlatform: map['paymentPlatform'],
    );
  }

  @override
  String toString() {
    return 'ActiveSubscription(subscribeDate: $subscribeDate, renewDate: $renewDate, subscriptionId: $subscriptionId, subscriptionName: $subscriptionName, amountPaid: $amountPaid, paymentPlatform: $paymentPlatform)';
  }
}
