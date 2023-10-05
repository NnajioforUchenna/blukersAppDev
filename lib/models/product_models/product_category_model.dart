import 'package:cloud_firestore/cloud_firestore.dart';

class ProductCategoryModel {
  final String id;
  final int createdAt;
  final int modifiedAt;
  final String name;
  final String description;
  final String imageUrl;

  ProductCategoryModel({
    this.id = "",
    required this.name,
    required this.description,
    this.imageUrl = "",
  })  : createdAt = DateTime.now().millisecondsSinceEpoch,
        modifiedAt = DateTime.now().millisecondsSinceEpoch;

  // Convert the object into a map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
    };
  }

  factory ProductCategoryModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ProductCategoryModel(
      // createdAt: data['createdAt'] ?? '',
      // modifiedAt: data['modifiedAt'] ?? '',
      id: data['id'] ?? '',
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
    );
  }

  // Create an object from a map
  static ProductCategoryModel fromMap(Map<String, dynamic> map) {
    return ProductCategoryModel(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      imageUrl: map['imageUrl'],
    );
  }

  @override
  String toString() {
    return 'ProductCategoryModel: { id: $id, name: $name, description: $description, imageUrl: $imageUrl }';
  }
}
