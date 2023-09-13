class PaidOrder {
  final String id;
  final int createdAt;
  final String orderStatus;
  final String productName;
  final String productCategoryName;
  final String productSubcategoryName;
  final String paymentPlatformName;
  final String orderNumber;
  final double orderTotalAmount;

  PaidOrder({
    required this.id,
    required this.createdAt,
    required this.orderStatus,
    required this.productName,
    required this.productCategoryName,
    required this.productSubcategoryName,
    required this.paymentPlatformName,
    required this.orderNumber,
    required this.orderTotalAmount,
  });

  // Optionally: A factory method to create an instance from a map (useful for deserialization)
  factory PaidOrder.fromMap(Map<String, dynamic> map) {
    return PaidOrder(
      id: map['id'],
      createdAt: map['createdAt'],
      orderStatus: map['orderStatus'],
      productName: map['productName'],
      productCategoryName: map['productCategoryName'],
      productSubcategoryName: map['productSubcategoryName'],
      paymentPlatformName: map['paymentPlatformName'],
      orderNumber: map['orderNumber'],
      orderTotalAmount: map['orderTotalAmount'].toDouble(),
    );
  }

  // Optionally: A method to convert the instance to a map (useful for serialization)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'createdAt': createdAt,
      'orderStatus': orderStatus,
      'productName': productName,
      'productCategoryName': productCategoryName,
      'productSubcategoryName': productSubcategoryName,
      'paymentPlatformName': paymentPlatformName,
      'orderNumber': orderNumber,
      'orderTotalAmount': orderTotalAmount,
    };
  }
}
