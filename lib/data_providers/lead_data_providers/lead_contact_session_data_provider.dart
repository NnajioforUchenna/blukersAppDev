import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/lead_models/lead_contact_session_model.dart';
import '../data_constants.dart';

class LeadContactSessionDataProvider {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String collectionName = leadContactSessionsCollection;

  Future<void> createLeadContactSession(
      LeadContactSessionModel objModel) async {
    final data = objModel.toMapFormatted();
    final id = _firestore.collection(collectionName).doc().id;
    data['id'] = id;
    await _firestore.collection(collectionName).doc(id).set(data);
  }

  Future<LeadContactSessionModel?> readLeadContactSession(String id) async {
    final DocumentSnapshot docSnapshot =
        await _firestore.collection(collectionName).doc(id).get();
    if (docSnapshot.exists) {
      return LeadContactSessionModel.fromFirestore(docSnapshot);
    } else {
      return null;
    }
  }

  Future<List<LeadContactSessionModel>> readAllLeadContactSessions() async {
    final QuerySnapshot querySnapshot =
        await _firestore.collection(collectionName).get();
    return querySnapshot.docs
        .map((doc) => LeadContactSessionModel.fromFirestore(doc))
        .toList();
  }

  Future<void> updateLeadContactSession(
    String id,
    Map<String, dynamic> data,
  ) async {
    await _firestore.collection(collectionName).doc(id).update(data);
  }

  Future<void> deleteLeadContactSession(String id) async {
    await _firestore.collection(collectionName).doc(id).delete();
  }
}
