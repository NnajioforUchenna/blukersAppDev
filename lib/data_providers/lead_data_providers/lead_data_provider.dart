import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:blukers/models/lead_models/lead_model.dart';
import '../data_constants.dart';

class LeadDataProvider {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String collectionName = leadsCollection;

  Future<void> createLead(LeadModel objModel) async {
    final data = objModel.toMapFormatted();
    final id = _firestore.collection(collectionName).doc().id;
    data['id'] = id;
    await _firestore.collection(collectionName).doc(id).set(data);
  }

  Future<LeadModel?> readLead(String id) async {
    final DocumentSnapshot docSnapshot =
        await _firestore.collection(collectionName).doc(id).get();
    if (docSnapshot.exists) {
      return LeadModel.fromFirestore(docSnapshot);
    } else {
      return null;
    }
  }

  Future<List<LeadModel>> readAllLeads() async {
    final QuerySnapshot querySnapshot =
        await _firestore.collection(collectionName).get();
    return querySnapshot.docs
        .map((doc) => LeadModel.fromFirestore(doc))
        .toList();
  }

  Future<void> updateLead(
    String id,
    Map<String, dynamic> data,
  ) async {
    await _firestore.collection(collectionName).doc(id).update(data);
  }

  Future<void> deleteLead(String id) async {
    await _firestore.collection(collectionName).doc(id).delete();
  }
}
