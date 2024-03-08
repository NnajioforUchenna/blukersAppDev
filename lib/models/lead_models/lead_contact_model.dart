import 'package:cloud_firestore/cloud_firestore.dart';

class LeadContactModel {
  final String id;

  final int createdAt;
  final int modifiedAt;

  final String leadId;
  final String appUserId;
  final String contactStatusId;
  final String contactMethodId;
  final String contactedByUserId;
  final String notes;
  final int contactDate; // Date and time contact took place with the lead
  final int followUpDate; // Date and time for the next follow-up with the lead

  LeadContactModel({
    this.id = "",
    required this.leadId,
    required this.appUserId,
    required this.contactStatusId,
    required this.contactMethodId,
    required this.contactedByUserId,
    required this.notes,
    required this.contactDate,
    required this.followUpDate,
  })  : createdAt = DateTime.now().millisecondsSinceEpoch,
        modifiedAt = DateTime.now().millisecondsSinceEpoch;

  factory LeadContactModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return LeadContactModel(
      // createdAt: data['createdAt'] ?? '',
      // modifiedAt: data['modifiedAt'] ?? '',
      id: data['id'] ?? '',
      leadId: data['leadId'] ?? '',
      appUserId: data['appUserId'] ?? '',
      contactStatusId: data['contactStatusId'] ?? '',
      contactMethodId: data['contactMethodId'] ?? '',
      contactedByUserId: data['contactedByUserId'] ?? '',
      notes: data['notes'] ?? '',
      contactDate: data['contactDate'] ?? '',
      followUpDate: data['followUpDate'] ?? '',
    );
  }

  // Create an object from a map
  static LeadContactModel fromMap(Map<String, dynamic> map) {
    return LeadContactModel(
      id: map['id'],
      leadId: map['leadId'],
      appUserId: map['appUserId'],
      contactStatusId: map['contactStatusId'],
      contactMethodId: map['contactMethodId'],
      contactedByUserId: map['contactedByUserId'],
      notes: map['notes'],
      contactDate: map['contactDate'],
      followUpDate: map['followUpDate'],
    );
  }

  // Convert the object into a map
  Map<String, dynamic> toMap() {
    return {
      'createdAt': createdAt,
      'modifiedAt': modifiedAt,
      'id': id,
      'leadId': leadId,
      'appUserId': appUserId,
      'contactStatusId': contactStatusId,
      'contactMethodId': contactMethodId,
      'contactedByUserId': contactedByUserId,
      'notes': notes,
      'contactDate': contactDate,
      'followUpDate': followUpDate,
    };
  }

  @override
  String toString() {
    return 'LeadContactModel: { id: $id, leadId: $leadId, appUserId: $appUserId, contactStatusId: $contactStatusId, contactMethodId: $contactMethodId, contactedByUserId: $contactedByUserId, notes: $notes, contactDate: $contactDate, followUpDate: $followUpDate }';
  }

  LeadContactModel formatValues() {
    return LeadContactModel(
      id: id,
      leadId: leadId ?? '',
      appUserId: appUserId ?? '',
      contactStatusId: contactStatusId ?? '',
      contactMethodId: contactMethodId ?? '',
      contactedByUserId: contactedByUserId ?? '',
      notes: notes ?? '',
      contactDate: contactDate ?? 0,
      followUpDate: followUpDate ?? 0,
    );
  }

  Map<String, dynamic> toMapFormatted() {
    return {
      'createdAt': createdAt,
      'modifiedAt': modifiedAt,
      'id': id,
      'leadId': leadId ?? '',
      'appUserId': appUserId ?? '',
      'contactStatusId': contactStatusId ?? '',
      'contactMethodId': contactMethodId ?? '',
      'contactedByUserId': contactedByUserId ?? '',
      'notes': notes ?? '',
      'contactDate': contactDate ?? '',
      'followUpDate': followUpDate ?? '',
    };
  }
}
