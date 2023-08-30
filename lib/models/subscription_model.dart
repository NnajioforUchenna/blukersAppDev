class SubscriptionModel {
  final String id;
  final String title;
  final String description;
  final double price;
  final Duration duration;

  SubscriptionModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.duration,
  });
}
