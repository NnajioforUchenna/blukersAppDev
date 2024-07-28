import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';

import '../data_providers/job_posts_data_provider.dart';
import '../models/address.dart';
import '../models/app_user/app_user.dart';
import '../models/job_post.dart';
import '../views/auth/please_login_dialog.dart';
import '../views/company/create_job_post/create_job_post_components/compensation_and_contract_page.dart';
import '../views/worker/jobs_home/Components/display_selected_jobs/display_selected_jobs.dart';

class JobPostsProvider with ChangeNotifier {
  AppUser? appUser;

  Map<String, dynamic> newJobPostData = {};

  Map<String, JobPost> searchJobs = {};
  Map<String, JobPost> recent50Jobs = {};

  // Controls Displayed Job Posts
  Map<String, JobPost> displayedJobPosts = {};
  JobPost? selectedJobPost;

  // List<JobPost> selectedJobPosts = displayedJobPosts.values.toList();
  int jobPostCurrentPageIndex = 0;
  String selectedJobPostId = '';

  // Job Query Parameters
  String nameSearch = '';
  String locationSearch = '';
  String language = 'en';
  bool hasMore = true;

  update(AppUser? user) {
    appUser = user;
    if (appUser != null && appUser!.language != null) {
      language = appUser!.language ?? 'en';
    }
    notifyListeners();
  }

  bool searchComplete = false;

  void getJobPostsByJobID(String jobId, String targetLanguage) {
    searchComplete = false;
    selectedJobPostId = jobId;
    nameSearch = jobId;
    language = targetLanguage;

    // Get all jobPosts for the job with the given jobId.
    JobPostsDataProvider.getJobPostsByJobID(jobId, targetLanguage)
        .then((jobPosts) {
      List<JobPost> listJobPosts = [];

      listJobPosts = jobPosts
          .map((jobPost) {
            return JobPost.fromMap(jobPost);
          })
          .where((jobPost) => jobPost != null)
          .cast<JobPost>()
          .toList();

      if (listJobPosts.isNotEmpty) {
        selectedJobPost = listJobPosts.first;
      }

      displayedJobPosts = fillDisplayedJobPosts(listJobPosts);

      searchComplete = true;
      notifyListeners();
    });
  }

  void getJobsBySelection(BuildContext context, String jobId) {
    searchComplete = false;
    selectedJobPostId = jobId;
    nameSearch = jobId;
    language = appUser?.language ?? 'en';

    // Get all jobPosts for the job with the given jobId.
    JobPostsDataProvider.getJobPostsByJobID(jobId, language).then((jobPosts) {
      List<JobPost> listJobPosts = [];

      listJobPosts = jobPosts
          .map((jobPost) {
            return JobPost.fromMap(jobPost);
          })
          .where((jobPost) => jobPost != null)
          .cast<JobPost>()
          .toList();

      if (listJobPosts.isNotEmpty) {
        selectedJobPost = listJobPosts.first;
      }

      displayedJobPosts = fillDisplayedJobPosts(listJobPosts);

      searchComplete = true;
      notifyListeners();
    });

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => DisplaySelectedJobs(
          title: jobId,
        ),
      ),
    );
  }

  Future<void> translateJobPosts(targetLanguage) async {
    language = targetLanguage;

    getRealJobPosts();
    notifyListeners();
  }

  void setSelectedJobPost(JobPost jobPost) {
    selectedJobPost = jobPost;
    notifyListeners();
  }

  Map<String, dynamic> previousParams = {};

  void createNewJobPost(AppUser? appUser, BuildContext context) {
    if (appUser == null) {
      showDialog(
          context: context, builder: (context) => const PleaseLoginDialog());
    } else {
      newJobPostData['companyId'] = appUser.uid;
      newJobPostData['companyName'] = appUser.company?.name;
      newJobPostData['companyLogo'] = appUser.company?.logoUrl;
      context.push('/createJobPost');
    }
  }

  void setIndustryAndJob(String industryId, String jobId) {
    // store previous params
    previousParams['industryId'] = industryId;
    previousParams['jobId'] = jobId;

    newJobPostData['industryIds'] = [industryId];
    newJobPostData['jobIds'] = [jobId];
    setJobPostPageNext();
  }

  void setJobPostPageNext() {
    jobPostCurrentPageIndex++;
    notifyListeners();
  }

  void setJobPostPagePrevious() {
    jobPostCurrentPageIndex--;
    notifyListeners();
  }

  void addBasicInformation(String title, String description,
      String positionsAvailable, int urgencyValue) {
    // store previous params
    previousParams['title'] = title;
    previousParams['description'] = description;
    previousParams['positionsAvailable'] = positionsAvailable;
    previousParams['urgencyValue'] = urgencyValue;

    newJobPostData['jobTitle'] = title;
    newJobPostData['jobDescription'] = description;
    newJobPostData['numberOfPositionsAvailable'] = positionsAvailable;
    newJobPostData['jobUrgencyLevel'] = urgencyValue;
    setJobPostPageNext();
  }

  void addQualificationAndSkills(
      String requirements, List<String> selectedSkillNames) {
    // store previous params
    previousParams['requirements'] = requirements;
    previousParams['selectedSkillNames'] = selectedSkillNames;

    newJobPostData['requirements'] = requirements;
    newJobPostData['skills'] = selectedSkillNames;
    setJobPostPageNext();
  }

  void addCompensationAndContract({
    JobType? jobType,
    String? salaryAmount,
    SalaryPeriod? salaryPeriod,
    int? durationInMonth,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    // store previous params
    previousParams['jobType'] = jobType;
    previousParams['salaryAmount'] = salaryAmount;
    previousParams['salaryPeriod'] = salaryPeriod;
    previousParams['durationInMonth'] = durationInMonth;
    previousParams['startDate'] = startDate;
    previousParams['endDate'] = endDate;

    if (jobType != null) {
      newJobPostData['jobType'] = jobType.index;
    }
    if (salaryAmount != null) {
      newJobPostData['salaryAmount'] = salaryAmount;
    }
    if (salaryPeriod != null) {
      newJobPostData['salaryPeriod'] = salaryPeriod;
    }
    if (durationInMonth != null) {
      newJobPostData['durationInMonth'] = durationInMonth;
    }
    if (startDate != null) {
      newJobPostData['startDate'] = startDate;
    }
    if (endDate != null) {
      newJobPostData['endDate'] = endDate;
    }
    setJobPostPageNext();
  }

  void updateUserAddress(String street, String city, String state,
      String postalCode, String Country) {
    Address address = Address(
        street: street,
        city: city,
        state: state,
        postalCode: postalCode,
        country: Country);

    newJobPostData['addresses'] = [address.toMap()];
    newJobPostData['address'] = address.toMap();
    createJobPost();
    setJobPostPageNext();
  }

  Future<void> createJobPost() async {
    // make sure that the jobPost accepts JobPost Model
    JobPost? jobPost = JobPost.fromMap(newJobPostData);
    if (jobPost != null) {
      jobPost.dateCreated = DateTime.now().millisecondsSinceEpoch;
      await JobPostsDataProvider.createJobPost(jobPost);
      notifyListeners();
      // in 20 seconds reset the Used Paramters
      Future.delayed(const Duration(seconds: 20), () {
        newJobPostData = {};
        previousParams = {};
        jobPostCurrentPageIndex = 0;
      });
    } else {
      // Handle the error case when jobPost is null
      print('Failed to create JobPost from the provided data');
    }
  }

  Future<List<JobPost>> getAppliedJobPostIds(String uid) {
    return JobPostsDataProvider.getAppliedJobPostIds(uid)
        .then((ids) => JobPostsDataProvider.getJobPostsByCompanyIds(ids));
  }

  Future<List<JobPost>> getSavedJobPostIds(String uid) async {
    try {
      final ids = await JobPostsDataProvider.getSavedJobPostIds(uid);
      final jobPosts = await JobPostsDataProvider.getJobPostsByCompanyIds(ids);
      return jobPosts;
    } catch (error) {
      // Handle the error as needed, perhaps by returning an empty list or throwing a specific exception.
      return [];
    }
  }

  // Searching Parameters for Job Posts
  bool isSearching = false;

  Future<void> searchJobPosts(
      String nameRelated, String locationRelated) async {
    nameSearch = nameRelated;
    locationSearch = locationRelated;

    displayedJobPosts.clear();

    List<JobPost> listJobPosts = await JobPostsDataProvider.searchJobPosts(
        nameRelated: nameRelated,
        locationRelated: locationRelated,
        pageNumber: 0,
        targetLanguage: language);

    print('listJobPosts: $listJobPosts');

    hasMore = listJobPosts.isNotEmpty;

    if (listJobPosts.isEmpty) {
      EasyLoading.showError('No Jobs Found with $nameRelated $locationRelated');
    } else {
      displayedJobPosts = fillDisplayedJobPosts(listJobPosts);
      selectedJobPost = listJobPosts.first;
      isSearching = true;
      notifyListeners();
    }
  }

  void setSearching(bool bool) {
    isSearching = bool;
    notifyListeners();
  }

  void clearSearchParameters() {
    nameSearch = '';
    locationSearch = '';
    isSearching = false;
    notifyListeners();
  }

  bool isWebSearching = false;

  Future<void> getJobsBySearchParameter(
      String nameSearch, String locationSearch) async {
    nameSearch = nameSearch;
    locationSearch = locationSearch;
    List<JobPost> searchJobPosts = await JobPostsDataProvider.searchJobPosts(
        nameRelated: nameSearch,
        locationRelated: locationSearch,
        pageNumber: 0,
        targetLanguage: language);
    hasMore = searchJobPosts.isNotEmpty;
    if (searchJobPosts.isEmpty) {
      EasyLoading.showError('No Jobs Found with $nameSearch $locationSearch');
    } else {
      for (var element in searchJobPosts) {
        searchJobs[element.jobPostId] = element;
      }
      isWebSearching = true;
      notifyListeners();
    }
  }

  void get50LastestJobPosts() async {
    // Get the 50 most recent job posts.
    List<Map<String, dynamic>> jobPosts =
        await JobPostsDataProvider.getAiJobPosts(
            queryName: "",
            queryLocation: "",
            pageNumber: 0,
            targetLanguage: language);
    hasMore = jobPosts.isNotEmpty;
    recent50Jobs = {};
    for (var jobPost in jobPosts) {
      if (jobPost['id'] != null) {
        JobPost? parsedJobPost = JobPost.fromMap(jobPost);
        if (parsedJobPost != null) {
          recent50Jobs[jobPost['id']] = parsedJobPost;
        }
      }
    }

    notifyListeners();
  }

  Future<void> getRealJobPosts() async {
    // Get the 50 most recent job posts.

    if (appUser != null && appUser!.language != null) {
      language = appUser!.language ?? 'en';
    }

    List<Map<String, dynamic>> jobPosts =
        await JobPostsDataProvider.getAiJobPosts(
            queryName: "",
            queryLocation: "",
            pageNumber: 0,
            targetLanguage: language);

    hasMore = jobPosts.isNotEmpty;

    displayedJobPosts = {};

    for (var jobPost in jobPosts) {
      if (jobPost['jobPostId'] != null) {
        JobPost? parsedJobPost = JobPost.fromMap(jobPost);
        if (parsedJobPost != null) {
          displayedJobPosts[jobPost['jobPostId']] = parsedJobPost;
        }
      }
    }

    if (displayedJobPosts.isNotEmpty) {
      selectedJobPost = displayedJobPosts.values.first;
    }

    notifyListeners();
  }

  Future<Map<String, JobPost>> loadMoreJobPosts({
    required String queryName,
    required String queryLocation,
    required int pageNumber,
    required String targetLanguage,
  }) async {
    // Get the 50 most recent job posts.
    Map<String, JobPost> newJobs = {};

    List<Map<String, dynamic>> jobPosts =
        await JobPostsDataProvider.getAiJobPosts(
            queryName: queryName,
            queryLocation: queryLocation,
            pageNumber: pageNumber,
            targetLanguage: targetLanguage);

    hasMore = jobPosts.isNotEmpty;

    for (var jobPost in jobPosts) {
      if (jobPost['jobPostId'] != null) {
        JobPost? parsedJobPost = JobPost.fromMap(jobPost);
        if (parsedJobPost != null) {
          newJobs[jobPost['jobPostId']] = parsedJobPost;
        }
      }
    }

    return newJobs;
  }

  Map<String, JobPost> fillDisplayedJobPosts(List<JobPost> listJobPosts) {
    Map<String, JobPost> newDisplayedJobPosts = {};
    for (var jobPost in listJobPosts) {
      newDisplayedJobPosts[jobPost.jobPostId] = jobPost;
    }
    return newDisplayedJobPosts;
  }

// Future<List<JobPost>> getSavedJobPostIds(String uid) {
//   return JobPostsDataProvider.getSavedJobPostIds(uid)
//       .then((ids) => JobPostsDataProvider.getJobPostsByCompanyIds(ids));
// }

// delete jobs posted
  Future<void> deleteJobPost(String jobPostId) async {
    JobPostsDataProvider.deleteJobPost(jobPostId, appUser!.uid);
    notifyListeners();
  }
}
