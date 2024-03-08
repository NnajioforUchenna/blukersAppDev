import 'package:cloud_firestore/cloud_firestore.dart';

class LeadModel {
  final String id;

  final int createdAt;
  final int modifiedAt;

  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String company;
  final String statusId;
  final String appUserId;

  LeadModel({
    this.id = "",
    required this.firstName,
    required this.lastName,
    this.email = "",
    this.phone = "",
    this.company = "",
    this.statusId = "",
    this.appUserId = "",
  })  : createdAt = DateTime.now().millisecondsSinceEpoch,
        modifiedAt = DateTime.now().millisecondsSinceEpoch;

  factory LeadModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return LeadModel(
      // createdAt: data['createdAt'] ?? '',
      // modifiedAt: data['modifiedAt'] ?? '',
      id: data['id'] ?? '',
      firstName: data['firstName'] ?? '',
      lastName: data['lastName'] ?? '',
      email: data['email'] ?? '',
      phone: data['phone'] ?? '',
      company: data['company'] ?? '',
      statusId: data['statusId'] ?? '',
      appUserId: data['appUserId'] ?? '',
    );
  }

  // Create an object from a map
  static LeadModel fromMap(Map<String, dynamic> map) {
    return LeadModel(
      id: map['id'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      email: map['email'],
      phone: map['phone'],
      company: map['company'],
      statusId: map['statusId'],
      appUserId: map['appUserId'],
    );
  }

  // Convert the object into a map
  Map<String, dynamic> toMap() {
    return {
      'createdAt': createdAt,
      'modifiedAt': modifiedAt,
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phone': phone,
      'company': company,
      'statusId': statusId,
      'appUserId': appUserId,
    };
  }

  @override
  String toString() {
    return 'LeadModel: { id: $id, firstName: $firstName, lastName: $lastName, email: $email, phone: $phone, '
        'company: $company, statusId: $statusId, appUserId: $appUserId }';
  }

  LeadModel formatValues() {
    return LeadModel(
      id: id,
      firstName: firstName ?? '',
      lastName: lastName ?? '',
      email: email ?? '',
      phone: phone ?? '',
      company: company ?? '',
      statusId: statusId ?? '',
      appUserId: appUserId ?? '',
    );
  }

  Map<String, dynamic> toMapFormatted() {
    return {
      'createdAt': createdAt,
      'modifiedAt': modifiedAt,
      'id': id,
      'firstName': firstName ?? '',
      'lastName': lastName ?? '',
      'email': email ?? '',
      'phone': phone ?? '',
      'company': company ?? '',
      'statusId': statusId ?? '',
      'appUserId': appUserId ?? '',
    };
  }
}
