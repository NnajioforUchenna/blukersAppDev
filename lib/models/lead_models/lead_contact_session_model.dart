import 'package:cloud_firestore/cloud_firestore.dart';
import 'lead_contact_model.dart';

class LeadContactSessionModel {
  final String id;

  final int createdAt;
  final int modifiedAt;

  final String leadId;
  final String userIdInCharge;
  final String createdByUserId;
  final String leadContactSessionStatusId;
  final List<LeadContactModel> leadContactHistory;

  LeadContactSessionModel({
    this.id = "",
    required this.leadId,
    required this.userIdInCharge,
    required this.createdByUserId,
    required this.leadContactSessionStatusId,
    required this.leadContactHistory,
  })  : createdAt = DateTime.now().millisecondsSinceEpoch,
        modifiedAt = DateTime.now().millisecondsSinceEpoch;

  factory LeadContactSessionModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return LeadContactSessionModel(
      // createdAt: data['createdAt'] ?? '',
      // modifiedAt: data['modifiedAt'] ?? '',
      id: data['id'] ?? '',
      leadId: data['leadId'] ?? '',
      userIdInCharge: data['userIdInCharge'] ?? '',
      createdByUserId: data['createdByUserId'] ?? '',
      leadContactSessionStatusId: data['leadContactSessionStatusId'] ?? '',
      leadContactHistory: data['leadContactHistory'] ?? '',
    );
  }

  // Create an object from a map
  static LeadContactSessionModel fromMap(Map<String, dynamic> map) {
    return LeadContactSessionModel(
      id: map['id'],
      leadId: map['leadId'],
      userIdInCharge: map['userIdInCharge'],
      createdByUserId: map['createdByUserId'],
      leadContactSessionStatusId: map['leadContactSessionStatusId'],
      leadContactHistory: map['leadContactHistory'],
    );
  }

  // Convert the object into a map
  Map<String, dynamic> toMap() {
    return {
      'createdAt': createdAt,
      'modifiedAt': modifiedAt,
      'id': id,
      'leadId': leadId,
      'userIdInCharge': userIdInCharge,
      'createdByUserId': createdByUserId,
      'leadContactSessionStatusId': leadContactSessionStatusId,
      'leadContactHistory': leadContactHistory,
    };
  }

  @override
  String toString() {
    return 'LeadContactSessionModel: { id: $id, leadId: $leadId, userIdInCharge: $userIdInCharge, createdByUserId: $createdByUserId, leadContactSessionStatusId: $leadContactSessionStatusId, leadContactHistory: $leadContactHistory }';
  }

  LeadContactSessionModel formatValues() {
    return LeadContactSessionModel(
      id: id,
      leadId: leadId ?? '',
      userIdInCharge: userIdInCharge ?? '',
      createdByUserId: createdByUserId ?? '',
      leadContactSessionStatusId: leadContactSessionStatusId ?? '',
      leadContactHistory: leadContactHistory ?? [],
    );
  }

  Map<String, dynamic> toMapFormatted() {
    return {
      'createdAt': createdAt,
      'modifiedAt': modifiedAt,
      'id': id,
      'leadId': leadId ?? '',
      'userIdInCharge': userIdInCharge ?? '',
      'createdByUserId': createdByUserId ?? '',
      'leadContactSessionStatusId': leadContactSessionStatusId ?? '',
      'leadContactHistory': leadContactHistory ?? '',
    };
  }
}
