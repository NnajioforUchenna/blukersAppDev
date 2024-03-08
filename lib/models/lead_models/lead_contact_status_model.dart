// To know how did the contact went:
// next-call-scheduled
// did-not-answer
// busy
// wants-to-purchase-service

import 'package:cloud_firestore/cloud_firestore.dart';

class LeadContactStatusModel {
  final String id;

  final int createdAt;
  final int modifiedAt;

  final String name;
  final String description;

  LeadContactStatusModel({
    this.id = "",
    required this.name,
    required this.description,
  })  : createdAt = DateTime.now().millisecondsSinceEpoch,
        modifiedAt = DateTime.now().millisecondsSinceEpoch;

  factory LeadContactStatusModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return LeadContactStatusModel(
      // createdAt: data['createdAt'] ?? '',
      // modifiedAt: data['modifiedAt'] ?? '',
      id: data['id'] ?? '',
      name: data['name'] ?? '',
      description: data['description'] ?? '',
    );
  }

  // Create an object from a map
  static LeadContactStatusModel fromMap(Map<String, dynamic> map) {
    return LeadContactStatusModel(
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
    return 'LeadContactStatusModel: { id: $id, name: $name, description: $description }';
  }

  LeadContactStatusModel formatValues() {
    return LeadContactStatusModel(
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
