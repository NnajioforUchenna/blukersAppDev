class ProductReviewModel {
  final String userId;
  final String productId;
  final String title;
  final String comments;

  ProductReviewModel({
    required this.userId,
    required this.productId,
    this.title = "",
    this.comments = "",
  });

  // Convert the object into a map
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'productId': productId,
      'title': title,
      'comments': comments,
    };
  }

  // Create an object from a map
  static ProductReviewModel fromMap(Map<String, dynamic> map) {
    return ProductReviewModel(
      userId: map['userId'],
      productId: map['productId'],
      title: map['title'],
      comments: map['comments'],
    );
  }

  @override
  String toString() {
    return 'ProductReviewModel: { userId: $userId, productId: $productId, title: $title, comments: $comments }';
  }
}
