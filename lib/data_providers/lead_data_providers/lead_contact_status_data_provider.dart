import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:blukers/models/lead_models/lead_contact_status_model.dart';
import '../data_constants.dart';

class LeadContactStatusDataProvider {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String collectionName = leadContactStatusesCollection;

  Future<void> createLeadContactStatus(LeadContactStatusModel objModel) async {
    final data = objModel.toMapFormatted();
    final id = _firestore.collection(collectionName).doc().id;
    data['id'] = id;
    await _firestore.collection(collectionName).doc(id).set(data);
  }

  Future<LeadContactStatusModel?> readLeadContactStatus(String id) async {
    final DocumentSnapshot docSnapshot =
        await _firestore.collection(collectionName).doc(id).get();
    if (docSnapshot.exists) {
      return LeadContactStatusModel.fromFirestore(docSnapshot);
    } else {
      return null;
    }
  }

  Future<List<LeadContactStatusModel>> readAllLeadContactStatuses() async {
    final QuerySnapshot querySnapshot =
        await _firestore.collection(collectionName).get();
    return querySnapshot.docs
        .map((doc) => LeadContactStatusModel.fromFirestore(doc))
        .toList();
  }

  Future<void> updateLeadContactStatus(
    String id,
    Map<String, dynamic> data,
  ) async {
    await _firestore.collection(collectionName).doc(id).update(data);
  }

  Future<void> deleteLeadContactStatus(String id) async {
    await _firestore.collection(collectionName).doc(id).delete();
  }
}
