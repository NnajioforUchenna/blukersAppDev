import 'package:cloud_firestore/cloud_firestore.dart';

class ProductSubcategoryModel {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final List<dynamic> categoryIds;

  ProductSubcategoryModel({
    this.id = "",
    required this.name,
    required this.description,
    this.imageUrl = "",
    this.categoryIds = const [],
  });

  // Convert the object into a map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'categoryIds': categoryIds,
    };
  }

  factory ProductSubcategoryModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ProductSubcategoryModel(
      // createdAt: data['createdAt'] ?? '',
      // modifiedAt: data['modifiedAt'] ?? '',
      id: data['id'] ?? '',
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      categoryIds: data['categoryIds'] ?? '',
    );
  }

  // Create an object from a map
  static ProductSubcategoryModel fromMap(Map<String, dynamic> map) {
    return ProductSubcategoryModel(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      imageUrl: map['imageUrl'],
      categoryIds: map['categoryIds'],
    );
  }

  @override
  String toString() {
    return 'ProductSubcategoryModel: { id: $id, name: $name, description: $description, imageUrl: $imageUrl, categoryIds: $categoryIds }';
  }
}
