import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

import '../common_files/constants.dart';
import '../models/job_post.dart';
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

    // Validate companyId
    if (jobPost.companyId == null || jobPost.companyId.isEmpty) {
      print('Company ID is null or empty');
      return;
    }

    // Add the retrieved document ID to the jobPostIds field in the relevant Companies document
    DocumentReference companyDoc = companies.doc(jobPost.companyId);

    // Use a try-catch block to handle any errors during update
    try {
      await companyDoc.update({
        'jobPostIds': FieldValue.arrayUnion([jobPostId])
      });
    } catch (e) {
      print('Failed to update company document: $e');
    }
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
    return List<String>.from(
        userDoc['worker.workerRecords.savedJobPostIds'] ?? []);
  }

  static Future<List<String>> getAppliedJobPostIds(String uid) async {
    DocumentSnapshot userDoc =
        await db.collection(appUserCollections).doc(uid).get();
    return List<String>.from(
        userDoc['worker.workerRecords.appliedJobPostIds'] ?? []);
  }

  static Future<List<JobPost>> getJobPostsByCompanyIds(
      List<String> jobPostIds) async {
    List<JobPost> jobPosts = [];
    for (String id in jobPostIds) {
      QuerySnapshot query = await db
          .collection(jobPostsCollections)
          .where('jobPostId', isEqualTo: id)
          .get();
      for (var doc in query.docs) {
        JobPost? jobPost = JobPost.fromMap(doc.data() as Map<String, dynamic>);
        if (jobPost != null) {
          jobPosts.add(jobPost);
        }
      }
    }
    return jobPosts;
  }

  static Future<List<JobPost>> searchJobPosts(
      {required String nameRelated,
      required String locationRelated,
      required int pageNumber,
      required String targetLanguage}) async {
    nameRelated = nameRelated.trim();
    locationRelated = locationRelated.trim();
    String keyword =
        ('${nameRelated}_${locationRelated}_${pageNumber}_$targetLanguage')
            .trim()
            .toLowerCase()
            .replaceAll(' ', '%20');

    print('Keyword: $keyword');

    final docRef = FirebaseFirestore.instance.collection('cache2').doc(keyword);
    final docSnapshot = await docRef.get();
    if (docSnapshot.exists) {
      print('Getting Record from Cache in Firebase');

      // The return Container
      final List<JobPost> jobPosts = [];

      // Getting the Data from the firestore docSnapshot
      final List<dynamic> jobPostData =
          docSnapshot.get('jobPosts') as List<dynamic>;

      // Converting the data to JobPost and adding to the container for return
      for (var data in jobPostData) {
        JobPost? jobPost = JobPost.fromMap(data);
        if (jobPost != null) {
          jobPosts.add(jobPost);
        }
      }

      return jobPosts;
    } else {
      print('Getting Record from API');
      String url =
          '$baseUrlAppEngineFunctions/search/get-job-posts'; // Replace with your actual endpoint

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
        for (var data in jobPostData) {
          JobPost? jobPost = JobPost.fromMap(data);
          if (jobPost != null) {
            jobPosts.add(jobPost);
          }
        }
        return jobPosts;
      } else {
        throw Exception('Failed to fetch job posts from the API');
      }
    }
  }

  static Future<List<JobPost>> translateJobPosts(
      String selectedJobPostId, String targetLanguage) async {
    List<JobPost> translatedJobPosts = [];

    if (selectedJobPostId.isNotEmpty) {
      final response = await http.post(
        Uri.parse(
            '$baseUrlAppEngineFunctions/getJobPostsByIdAndTargetLanguage'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'jobId': selectedJobPostId,
          'targetLanguage': targetLanguage,
        }),
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        if (jsonResponse is List) {
          for (var data in jsonResponse) {
            JobPost? jobPost = JobPost.fromMap(data as Map<String, dynamic>);
            if (jobPost != null) {
              translatedJobPosts.add(jobPost);
            }
          }
        }
      } else {
        print('Failed to load job posts. Error: ${response.body}');
      }
    }

    return translatedJobPosts;
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
        Uri.parse('$baseUrlAppEngineFunctions/search/get-job-posts'),
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

  // delete jobs posted
  static Future<void> deleteJobPost(String jobPostId, String companyId) async {
    await db.collection(jobPostsCollections).doc(jobPostId).delete();
    DocumentReference companyDoc =
        db.collection(companyCollections).doc(companyId);
    await companyDoc.update({
      'jobPostIds': FieldValue.arrayRemove([jobPostId])
    });
  }
}
