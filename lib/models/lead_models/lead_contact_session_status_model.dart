// To know how a session of lead contacts is going on:
// session-open
// session-active
// session-closed

import 'package:cloud_firestore/cloud_firestore.dart';

class LeadContactSessionStatusModel {
  final String id;

  final int createdAt;
  final int modifiedAt;

  final String name;
  final String description;

  LeadContactSessionStatusModel({
    this.id = "",
    required this.name,
    required this.description,
  })  : createdAt = DateTime.now().millisecondsSinceEpoch,
        modifiedAt = DateTime.now().millisecondsSinceEpoch;

  factory LeadContactSessionStatusModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return LeadContactSessionStatusModel(
      // createdAt: data['createdAt'] ?? '',
      // modifiedAt: data['modifiedAt'] ?? '',
      id: data['id'] ?? '',
      name: data['name'] ?? '',
      description: data['description'] ?? '',
    );
  }

  // Create an object from a map
  static LeadContactSessionStatusModel fromMap(Map<String, dynamic> map) {
    return LeadContactSessionStatusModel(
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
    return 'LeadContactSessionStatusModel: { id: $id, name: $name, description: $description }';
  }

  LeadContactSessionStatusModel formatValues() {
    return LeadContactSessionStatusModel(
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
