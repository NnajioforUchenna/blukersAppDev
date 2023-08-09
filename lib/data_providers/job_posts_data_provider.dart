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
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference jobPosts = db.collection('JobPosts');
    CollectionReference companies = db.collection('Companies');

    // Create a document reference and get the ID
    DocumentReference jobPostDoc = jobPosts.doc();
    String jobPostId = jobPostDoc.id;

    // Set the jobPostId inside the jobPost
    jobPost.jobPostId = jobPostId;

    // Add the JobPost to Firestore using the created reference
    await jobPostDoc
        .set(jobPost.toMap()); // Assuming JobPost has a toMap method

    // Add the retrieved document ID to the jobPostIds field in the relevant Companies document
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

  static searchJobPosts(String nameRelated, String locationRelated) async {
    CollectionReference jobPosts = db.collection('JobPosts');

    var queries = [
      jobPosts.where('companyName', isEqualTo: nameRelated),
      jobPosts.where('skills', arrayContains: nameRelated),
      jobPosts.where('jobTitle', isEqualTo: nameRelated),
      jobPosts.where('addresses.street', isEqualTo: locationRelated),
      jobPosts.where('addresses.city', isEqualTo: locationRelated),
      jobPosts.where('addresses.state', isEqualTo: locationRelated),
      jobPosts.where('addresses.country', isEqualTo: locationRelated),
    ];

    var allJobPosts = <JobPost>[];
    for (var query in queries) {
      final snapshot = await query.get();
      final jobPosts = snapshot.docs.map((doc) {
        return JobPost.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
      allJobPosts.addAll(jobPosts);
    }

    // Optionally, remove duplicates
    var uniqueJobPosts = <JobPost>{};
    uniqueJobPosts.addAll(allJobPosts);
    allJobPosts = uniqueJobPosts.toList();

    return allJobPosts;
  }
}
