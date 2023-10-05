import 'package:cloud_firestore/cloud_firestore.dart';

class ProductStatusModel {
  final String id;
  final String name;
  final String description;
  final String imageUrl;

  ProductStatusModel({
    this.id = "",
    required this.name,
    required this.description,
    this.imageUrl = "",
  });

  // Convert the object into a map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
    };
  }

  factory ProductStatusModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ProductStatusModel(
      // createdAt: data['createdAt'] ?? '',
      // modifiedAt: data['modifiedAt'] ?? '',
      id: data['id'] ?? '',
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
    );
  }

  // Create an object from a map
  static ProductStatusModel fromMap(Map<String, dynamic> map) {
    return ProductStatusModel(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      imageUrl: map['imageUrl'],
    );
  }

  @override
  String toString() {
    return 'ProductStatusModel: { id: $id, name: $name, description: $description, imageUrl: $imageUrl }';
  }
}
