import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseDataProvider<T> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String collectionName;

  FirebaseDataProvider(this.collectionName);

  Future<void> createDocument(T data) async {
    // Generate a unique document ID
    final id = _firestore.collection(collectionName).doc().id;
    // Save the ID in the data map if data is a Map<String, dynamic>
    if (data is Map<String, dynamic>) {
      (data as Map<String, dynamic>)['id'] = id;
    }
    // Add the document to Firestore with the specified ID
    await _firestore
        .collection(collectionName)
        .doc(id)
        .set(data as Map<String, dynamic>);
  }

  Future<T?> readDocument(String id) async {
    final DocumentSnapshot snapshot =
        await _firestore.collection(collectionName).doc(id).get();

    if (snapshot.exists) {
      snapshot.data() as T?;
    } else {
      null;
    }
    return null;
  }

  Future<List<T>> readAllDocuments() async {
    final QuerySnapshot querySnapshot =
        await _firestore.collection(collectionName).get();
    return querySnapshot.docs.map((doc) => doc.data() as T).toList();
  }

  Future<void> updateDocument(
    String id,
    Map<String, dynamic> data,
  ) async {
    await _firestore.collection(collectionName).doc(id).update(data);
  }

  Future<void> deleteDocument(String id) async {
    await _firestore.collection(collectionName).doc(id).delete();
  }
}
