import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LeadContactMethodModel {
  final String id;

  final int createdAt;
  final int modifiedAt;

  final String name;
  final String description;

  LeadContactMethodModel({
    this.id = "",
    required this.name,
    required this.description,
  })  : createdAt = DateTime.now().millisecondsSinceEpoch,
        modifiedAt = DateTime.now().millisecondsSinceEpoch;

  factory LeadContactMethodModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return LeadContactMethodModel(
      // createdAt: data['createdAt'] ?? '',
      // modifiedAt: data['modifiedAt'] ?? '',
      id: data['id'] ?? '',
      name: data['name'] ?? '',
      description: data['description'] ?? '',
    );
  }

  // Create an object from a map
  static LeadContactMethodModel fromMap(Map<String, dynamic> map) {
    return LeadContactMethodModel(
      id: map['id'],
      name: map['name'],
      description: map['description'],
    );
  }

  // Convert the object into a map
  Map<String, dynamic> toMap() {
    return {
      'createdAt': createdAt,
      'modifiedAt': modifiedAt,
      'id': id,
      'name': name,
      'description': description,
    };
  }

  @override
  String toString() {
    return 'LeadContactMethodModel: { id: $id, name: $name, description: $description }';
  }

  LeadContactMethodModel formatValues() {
    return LeadContactMethodModel(
      id: id,
      name: name ?? '',
      description: description ?? '',
    );
  }

  Map<String, dynamic> toMapFormatted() {
    return {
      'createdAt': createdAt,
      'modifiedAt': modifiedAt,
      'id': id,
      'name': name ?? '',
      'description': description ?? '',
    };
  }
}
