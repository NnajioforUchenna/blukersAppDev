import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/lead_models/lead_contact_model.dart';
import '../data_constants.dart';

class LeadContactDataProvider {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String collectionName = leadContactsCollection;

  Future<void> createLeadContact(LeadContactModel objModel) async {
    final data = objModel.toMapFormatted();
    final id = _firestore.collection(collectionName).doc().id;
    data['id'] = id;
    await _firestore.collection(collectionName).doc(id).set(data);
  }

  Future<LeadContactModel?> readLeadContact(String id) async {
    final DocumentSnapshot docSnapshot =
        await _firestore.collection(collectionName).doc(id).get();

    if (docSnapshot.exists) {
      return LeadContactModel.fromFirestore(docSnapshot);
    } else {
      return null;
    }
  }

  Future<List<LeadContactModel>> readAllLeadContacts() async {
    final QuerySnapshot querySnapshot =
        await _firestore.collection(collectionName).get();
    return querySnapshot.docs
        .map((doc) => LeadContactModel.fromFirestore(doc))
        .toList();
  }

  Future<void> updateLeadContact(
    String id,
    Map<String, dynamic> data,
  ) async {
    await _firestore.collection(collectionName).doc(id).update(data);
  }

  Future<void> deleteLeadContact(String id) async {
    await _firestore.collection(collectionName).doc(id).delete();
  }
}
