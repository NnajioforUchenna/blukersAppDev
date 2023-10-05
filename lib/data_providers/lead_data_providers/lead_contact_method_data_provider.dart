import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:blukers/models/lead_models/lead_contact_method_model.dart';
import '../data_constants.dart';

class LeadContactMethodDataProvider {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String collectionName = leadContactMethodsCollection;

  Future<void> createLeadContactMethod(LeadContactMethodModel objModel) async {
    final data = objModel.toMapFormatted();
    final id = _firestore.collection(collectionName).doc().id;
    data['id'] = id;
    await _firestore.collection(collectionName).doc(id).set(data);
  }

  Future<LeadContactMethodModel?> readLeadContactMethod(String id) async {
    final DocumentSnapshot docSnapshot =
        await _firestore.collection(collectionName).doc(id).get();
    if (docSnapshot.exists) {
      return LeadContactMethodModel.fromFirestore(docSnapshot);
    } else {
      return null;
    }
  }

  Future<List<LeadContactMethodModel>> readAllLeadContactMethods() async {
    final QuerySnapshot querySnapshot =
        await _firestore.collection(collectionName).get();
    return querySnapshot.docs
        .map((doc) => LeadContactMethodModel.fromFirestore(doc))
        .toList();
  }

  Future<void> updateLeadContactMethod(
    String id,
    Map<String, dynamic> data,
  ) async {
    await _firestore.collection(collectionName).doc(id).update(data);
  }

  Future<void> deleteLeadContactMethod(String id) async {
    await _firestore.collection(collectionName).doc(id).delete();
  }
}
