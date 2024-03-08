// Work in progress...
// This file is not finished...
// Purpose of this file is to make some universal or generic reusable functions
// when doing common CRUD operations using firebase or any other database...
//
// We can just add here the Firebase code required to perform any CRUD
// operation and just call it outside this file in the next ways:
//
// Initialize it ('Products' model example):
// final firebaseDataProvider = FirebaseDataProvider<Product>('Products');
// Where Product is the model type, and 'Products' the firestore collection name.
//
// Create a document
// await firebaseDataProvider.createDocument(product);
//
// Read a document
// await firebaseDataProvider.readDocument(id);
//
// Read all documents
// await firebaseDataProvider.readAllDocuments();
//
// Update a document
// await firebaseDataProvider.updateDocument(product, id);
//
// Delete a document
// await firebaseDataProvider.deleteDocument(id);

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

  // Future<void> updateDocument(T data, String id) async {
  //   await _firestore
  //       .collection(collectionName)
  //       .doc(id)
  //       .update(data as Map<String, dynamic>);
  // }
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
