import 'package:cloud_firestore/cloud_firestore.dart';

class WorkerDataProvider {
  static Future<List<Map<String, dynamic>>> getWorkersByJobID(
      String jobId) async {
    // Create a reference to the Firestore collection
    CollectionReference workers =
        FirebaseFirestore.instance.collection('workers');

    // Query the collection: Fetch documents where jobId is in the jobPositionIds field
    QuerySnapshot querySnapshot =
        await workers.where('jobPositionIds', arrayContains: jobId).get();

    // Convert the documents to a list of maps and return
    return querySnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
  }
}
