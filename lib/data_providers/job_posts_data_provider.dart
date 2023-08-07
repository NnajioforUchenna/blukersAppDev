import 'package:bulkers/models/job_post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final db = FirebaseFirestore.instance;

class JobPostsDataProvider {
  static Future<List<Map<String, dynamic>>> getJobPostsByJobID(
      String jobId) async {
    // Create a reference to the Firestore collection
    CollectionReference jobPosts = db.collection('JobPosts');

    // Query the collection: Fetch documents where jobId is in the jobPositionIds field
    QuerySnapshot querySnapshot =
        await jobPosts.where('jobIds', arrayContains: jobId).get();

    // Convert the documents to a list of maps and return
    return querySnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
  }

  static Future<void> createJobPost(JobPost jobPost) async {
    CollectionReference jobPosts = db.collection('JobPosts');
    CollectionReference companies = db.collection('Companies');

    // Step 1: Push the JobPost to Firestore
    DocumentReference jobPostDoc = await jobPosts
        .add(jobPost.toMap()); // Assuming JobPost has a toMap method

    // Step 2: Retrieve the document ID of the newly created job post
    String jobPostId = jobPostDoc.id;

    // Step 3: Add the retrieved document ID to the jobPostIds field in the relevant Companies document
    DocumentReference companyDoc = companies.doc(jobPost.companyId);
    await companyDoc.update({
      'jobPostIds': FieldValue.arrayUnion([jobPostId])
    });
  }

  static void updateJobPostAppliedWorkerIds(String jobPostId, String uid) {
    CollectionReference jobPosts = db.collection('JobPosts');
    jobPosts.doc(jobPostId).update({
      'applicantUserIds': FieldValue.arrayUnion([uid])
    });
  }

  static Future<List<String>> getSavedJobPostIds(String uid) async {
    DocumentSnapshot userDoc = await db.collection('AppUsers').doc(uid).get();
    return List<String>.from(userDoc['worker.savedJobPostIds'] ?? []);
  }

  static Future<List<String>> getAppliedJobPostIds(String uid) async {
    DocumentSnapshot userDoc = await db.collection('AppUsers').doc(uid).get();
    return List<String>.from(userDoc['worker.appliedJobPostIds'] ?? []);
  }

  static Future<List<JobPost>> getJobPostsByCompanyIds(
      List<String> jobPostIds) async {
    List<JobPost> jobPosts = [];
    for (String id in jobPostIds) {
      QuerySnapshot query = await db
          .collection('JobPosts')
          .where('companyId', isEqualTo: id)
          .get();
      jobPosts.addAll(query.docs
          .map((doc) => JobPost.fromMap(doc.data() as Map<String, dynamic>))
          .toList());
    }
    return jobPosts;
  }
}
