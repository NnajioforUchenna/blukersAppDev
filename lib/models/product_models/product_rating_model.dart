class ProductRatingModel {
  final String userId;
  final String productId;
  final double rating;

  ProductRatingModel({
    required this.userId,
    required this.productId,
    this.rating = 0,
  });

  // Convert the object into a map
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'productId': productId,
      'rating': rating,
    };
  }

  // Create an object from a map
  static ProductRatingModel fromMap(Map<String, dynamic> map) {
    return ProductRatingModel(
      userId: map['userId'],
      productId: map['productId'],
      rating: map['rating'],
    );
  }

  @override
  String toString() {
    return 'ProductRatingModel: { userId: $userId, productId: $productId, rating: $rating }';
  }
}
