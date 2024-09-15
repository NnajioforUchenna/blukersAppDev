import 'package:blukers/models/job_post.dart';
import 'package:blukers/models/jobs_models/jobs_page_by_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/jobs_page.dart';
import 'data_constants.dart';
import 'job_posts_data_provider.dart';

final db = FirebaseFirestore.instance;

class JobsListsDataProvider {
  static Future<JobsPage> getAllJobsAtPage(JobsPage jobsPage) async {
    CollectionReference jobPosts =
        FirebaseFirestore.instance.collection(jobPostsCollections);

    // Number of job posts to fetch per page
    const int pageSize = 10;

    // Start the query based on lastDocument if present
    Query query =
        jobPosts.orderBy('dateCreated', descending: true).limit(pageSize);

    if (jobsPage.lastDocument != null) {
      query = query.startAfterDocument(jobsPage.lastDocument!);
    }

    // Execute the query
    QuerySnapshot querySnapshot = await query.get();

    // List to store job posts
    List<JobPost> jobPostList = [];

    // Process each document
    for (DocumentSnapshot document in querySnapshot.docs) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      JobPost? jobPost = JobPost.fromMap(data);
      if (jobPost != null) {
        jobPostList.add(jobPost);
      }
    }

    // Update the jobs page
    jobsPage.jobs.addAll(jobPostList);
    jobsPage.displayAllJobsPage++;

    if (jobPostList.isNotEmpty) {
      jobsPage.lastDocument = querySnapshot.docs.last;
    }

    return jobsPage;
  }

  static Future<JobsPageByPreferences> getJobsByPreferences(
      JobsPageByPreferences jobsPageByPreferences) async {
    String searchParameter = jobsPageByPreferences.getSearchParameter() ?? '';
    int pageNumber = jobsPageByPreferences.pageNumJobsByPreferences;
    String location = '';
    String language = jobsPageByPreferences.language;

    List<JobPost> jobPosts = await JobPostsDataProvider.searchJobPosts(
      nameRelated: searchParameter,
      locationRelated: location,
      pageNumber: pageNumber,
      targetLanguage: language,
    );

    jobsPageByPreferences.jobs.addAll(jobPosts);
    jobsPageByPreferences.pageNumJobsByPreferences++;

    return jobsPageByPreferences;
  }


  static Future<JobsPageByPreferences> getJobsByFilters(
    JobsPageByPreferences jobsPageByPreferences,
    List<String> selectedIndustries, // New parameter
    List<JobType> selectedJobTypes,  // New parameter
    JobUrgencyLevel urgencyValue,    // New parameter
    SalaryType selectedSalaryType    // New parameter
  ) async {
    String searchParameter = jobsPageByPreferences.getSearchParameter() ?? '';
    int pageNumber = jobsPageByPreferences.pageNumJobsByPreferences;
    String location = '';
    String language = jobsPageByPreferences.language;

    // Fetch all jobs based on general parameters
    List<JobPost> jobPosts = await JobPostsDataProvider.searchJobPosts(
      nameRelated: searchParameter,
      locationRelated: location,
      pageNumber: pageNumber,
      targetLanguage: language,
    );

    // Apply specific filters after fetching
    jobsPageByPreferences.jobs = jobPosts
        .where((job) => selectedIndustries.contains(job.industryIds))
        .where((job) => selectedJobTypes.contains(job.jobType))
        .where((job) => job.urgencyLevel == urgencyValue)
        .where((job) => job.salaryType == selectedSalaryType)
        .toList();

    jobsPageByPreferences.pageNumJobsByPreferences++;

    return jobsPageByPreferences;
  }




  
}
