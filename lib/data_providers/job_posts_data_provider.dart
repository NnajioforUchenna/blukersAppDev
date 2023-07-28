import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = FirebaseFirestore.instance;

class JobPostsDataProvider {
  static Future<List<Map<String, dynamic>>> getJobPostsByJobID(
      String jobId) async {
    // Create a reference to the Firestore collection
    CollectionReference jobPosts =
        FirebaseFirestore.instance.collection('JobPosts');

    // Query the collection: Fetch documents where jobId is in the jobPositionIds field
    QuerySnapshot querySnapshot =
        await jobPosts.where('jobIds', arrayContains: jobId).get();

    // Convert the documents to a list of maps and return
    return querySnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
  }
}
