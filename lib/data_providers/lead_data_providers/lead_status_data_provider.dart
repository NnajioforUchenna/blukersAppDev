import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/lead_models/lead_status_model.dart';
import '../data_constants.dart';

class LeadStatusDataProvider {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String collectionName = leadStatusesCollection;

  Future<void> createLeadStatus(LeadStatusModel objModel) async {
    final data = objModel.toMapFormatted();
    final id = _firestore.collection(collectionName).doc().id;
    data['id'] = id;
    await _firestore.collection(collectionName).doc(id).set(data);
  }

  Future<LeadStatusModel?> readLeadStatus(String id) async {
    final DocumentSnapshot docSnapshot =
        await _firestore.collection(collectionName).doc(id).get();
    if (docSnapshot.exists) {
      return LeadStatusModel.fromFirestore(docSnapshot);
    } else {
      return null;
    }
  }

  Future<List<LeadStatusModel>> readAllLeadStatuses() async {
    final QuerySnapshot querySnapshot =
        await _firestore.collection(collectionName).get();
    return querySnapshot.docs
        .map((doc) => LeadStatusModel.fromFirestore(doc))
        .toList();
  }

  Future<void> updateLeadStatus(
    String id,
    Map<String, dynamic> data,
  ) async {
    await _firestore.collection(collectionName).doc(id).update(data);
  }

  Future<void> deleteLeadStatus(String id) async {
    await _firestore.collection(collectionName).doc(id).delete();
  }
}
