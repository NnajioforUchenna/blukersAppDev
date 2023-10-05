import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:blukers/models/lead_models/lead_contact_session_status_model.dart';
import '../data_constants.dart';

class LeadContactSessionStatusDataProvider {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String collectionName = leadContactSessionStatusesCollection;

  Future<void> createLeadContactSessionStatus(
      LeadContactSessionStatusModel objModel) async {
    final data = objModel.toMapFormatted();
    final id = _firestore.collection(collectionName).doc().id;
    data['id'] = id;
    await _firestore.collection(collectionName).doc(id).set(data);
  }

  Future<LeadContactSessionStatusModel?> readLeadContactSessionStatus(
      String id) async {
    final DocumentSnapshot docSnapshot =
        await _firestore.collection(collectionName).doc(id).get();
    if (docSnapshot.exists) {
      return LeadContactSessionStatusModel.fromFirestore(docSnapshot);
    } else {
      return null;
    }
  }

  Future<List<LeadContactSessionStatusModel>>
      readAllLeadContactSessionStatuses() async {
    final QuerySnapshot querySnapshot =
        await _firestore.collection(collectionName).get();
    return querySnapshot.docs
        .map((doc) => LeadContactSessionStatusModel.fromFirestore(doc))
        .toList();
  }

  Future<void> updateLeadContactSessionStatus(
    String id,
    Map<String, dynamic> data,
  ) async {
    await _firestore.collection(collectionName).doc(id).update(data);
  }

  Future<void> deleteLeadContactSessionStatus(String id) async {
    await _firestore.collection(collectionName).doc(id).delete();
  }
}
