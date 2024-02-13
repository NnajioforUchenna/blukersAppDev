import 'dart:convert';

import 'package:blukers/models/job_post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

import '../common_files/constants.dart';
import 'data_constants.dart';

final db = FirebaseFirestore.instance;

class JobPostsDataProvider {
  static Future<List<Map<String, dynamic>>> getJobPostsByJobID(
      String jobId, String targetLanguage) async {
    List<JobPost> jobPosts = await searchJobPosts(
        nameRelated: jobId,
        locationRelated: '',
        pageNumber: 0,
        targetLanguage: targetLanguage);
    return jobPosts.map((jobPost) => jobPost.toMap()).toList();
  }

  static Future<void> createJobPost(JobPost jobPost) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference jobPosts = db.collection(jobPostsCollections);
    CollectionReference companies = db.collection(companyCollections);

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
    CollectionReference jobPosts = db.collection(jobPostsCollections);
    jobPosts.doc(jobPostId).update({
      'applicantUserIds': FieldValue.arrayUnion([uid])
    });
  }

  static Future<List<String>> getSavedJobPostIds(String uid) async {
    DocumentSnapshot userDoc =
        await db.collection(appUserCollections).doc(uid).get();
    return List<String>.from(userDoc['worker.savedJobPostIds'] ?? []);
  }

  static Future<List<String>> getAppliedJobPostIds(String uid) async {
    DocumentSnapshot userDoc =
        await db.collection(appUserCollections).doc(uid).get();
    return List<String>.from(userDoc['worker.appliedJobPostIds'] ?? []);
  }

  static Future<List<JobPost>> getJobPostsByCompanyIds(
      List<String> jobPostIds) async {
    List<JobPost> jobPosts = [];
    for (String id in jobPostIds) {
      QuerySnapshot query = await db
          .collection(jobPostsCollections)
          .where('jobPostId', isEqualTo: id)
          .get();
      query.docs.forEach((doc) {
        JobPost? jobPost = JobPost.fromMap(doc.data() as Map<String, dynamic>);
        if (jobPost != null) {
          jobPosts.add(jobPost);
        }
      });
    }
    return jobPosts;
  }

  // static searchJobPosts(String nameRelated, String locationRelated) async {
  //   CollectionReference jobPosts = db.collection(jobPostsCollections);
  //
  //   var queries = [
  //     jobPosts.where('companyName', isEqualTo: nameRelated),
  //     jobPosts.where('skills', arrayContains: nameRelated),
  //     jobPosts.where('jobTitle', isEqualTo: nameRelated),
  //     jobPosts.where('jobIds', isEqualTo: nameRelated),
  //     jobPosts.where('addresses.street', isEqualTo: locationRelated),
  //     jobPosts.where('addresses.city', isEqualTo: locationRelated),
  //     jobPosts.where('addresses.state', isEqualTo: locationRelated),
  //     jobPosts.where('addresses.country', isEqualTo: locationRelated),
  //   ];
  //
  //   var allJobPosts = <JobPost>[];
  //   for (var query in queries) {
  //     final snapshot = await query.get();
  //     final jobPosts = snapshot.docs.map((doc) {
  //       return JobPost.fromMap(doc.data() as Map<String, dynamic>);
  //     }).toList();
  //     allJobPosts.addAll(jobPosts);
  //   }
  //
  //   // Optionally, remove duplicates
  //   var uniqueJobPosts = <JobPost>{};
  //   uniqueJobPosts.addAll(allJobPosts);
  //   allJobPosts = uniqueJobPosts.toList();
  //
  //   return allJobPosts;
  // }

  static Future<List<JobPost>> searchJobPosts(
      {required String nameRelated,
      required String locationRelated,
      required int pageNumber,
      required String targetLanguage}) async {
    String url = baseUrlAppEngineFunctions +
        '/search/get-job-posts'; // Replace with your actual endpoint

    Map<String, dynamic> jsonBody = {
      "query_name": nameRelated.toLowerCase(),
      "query_location": locationRelated,
      "page_number": pageNumber,
      "target_language": targetLanguage,
    };

    // print(jsonBody);

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(jsonBody),
    );

    if (response.statusCode == 200) {
      final sanitizedResponseBody = sanitizeJson(response.body);
      final List<dynamic> jobPostData = jsonDecode(sanitizedResponseBody);
      final List<JobPost> jobPosts = [];
      jobPostData.forEach((data) {
        JobPost? jobPost = JobPost.fromMap(data);
        if (jobPost != null) {
          jobPosts.add(jobPost);
        }
      });
      return jobPosts;
    } else {
      throw Exception('Failed to fetch job posts from the API');
    }
  }

  static Future<List<JobPost>> translateJobPosts(
      String selectedJobPostId, String targetLanguage) async {
    List<JobPost> translatedJobPosts = [];

    if (selectedJobPostId.isNotEmpty) {
      final response = await http.post(
        Uri.parse(
            baseUrlAppEngineFunctions + '/getJobPostsByIdAndTargetLanguage'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'jobId': selectedJobPostId,
          'targetLanguage': targetLanguage,
        }),
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        if (jsonResponse is List) {
          jsonResponse.forEach((data) {
            JobPost? jobPost = JobPost.fromMap(data as Map<String, dynamic>);
            if (jobPost != null) {
              translatedJobPosts.add(jobPost);
            }
          });
        }
      } else {
        print('Failed to load job posts. Error: ${response.body}');
      }
    }

    return translatedJobPosts;
  }

  static Future<List<Map<String, dynamic>>> getRecentJobPosts2() async {
    // Create a reference to the Firestore collection
    CollectionReference jobPosts = db.collection("ScrappedJobs");

    // Query the collection: Order by dateCreated descending and limit to 50
    QuerySnapshot querySnapshot =
        await jobPosts.orderBy('dateCreated', descending: true).limit(50).get();

    // Convert the documents to a list of maps, adding the document ID
    return querySnapshot.docs
        .map((doc) => {
              'id': doc.id, // Add the document ID
              ...doc.data() as Map<String, dynamic>,
            })
        .toList();
  }

  static Future<List<Map<String, dynamic>>> getAiJobPosts({
    required String queryName,
    required String queryLocation,
    required int pageNumber,
    required String targetLanguage,
  }) async {
    // Define the payload using the provided parameters
    var body = jsonEncode({
      "query_name": queryName,
      "query_location": queryLocation,
      "page_number": pageNumber,
      "target_language": targetLanguage,
    });

    // Make the HTTP request
    var response = await http.post(
        Uri.parse(baseUrlAppEngineFunctions + '/search/get-job-posts'),
        headers: {"Content-Type": "application/json"},
        body: body);

    // If the call to the server was successful, parse the JSON
    if (response.statusCode == 200) {
      String sanitizedBody = sanitizeJson(response.body);
      return List<Map<String, dynamic>>.from(json.decode(sanitizedBody));
    } else {
      throw Exception('Failed to load AI job posts');
    }
  }
}
