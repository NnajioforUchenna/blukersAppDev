import 'package:blukers/models/app_user.dart';
import 'package:blukers/views/company/my_job_posts_components/create_job_post_components/compensation_and_contract_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../data_providers/job_posts_data_provider.dart';
import '../models/address.dart';
import '../models/job_post.dart';
import '../views/common_views/please_login_dialog.dart';

class JobPostsProvider with ChangeNotifier {
  Map<String, JobPost> _jobPosts = {};
  Map<String, dynamic> newJobPostData = {};

  Map<String, JobPost> searchJobs = {};
  Map<String, JobPost> recent50Jobs = {};

  JobPost? selectedJobPost;

  Map<String, JobPost> get jobPosts => _jobPosts;
  bool isReal = true;

  List<JobPost> selectedJobPosts = [];
  int jobPostCurrentPageIndex = 0;
  String selectedJobPostId = '';

  Map<String, JobPost> realJobPosts = {};

  JobPostsProvider() {
    get50LastestJobPosts();
    getRealJobPosts();
  }

  bool searchComplete = false;

  void getJobPostsByJobID(String jobId) {
    print('getJobPostsByJobID: $jobId');
    searchComplete = false;
    selectedJobPostId = jobId;

    // Get all jobPosts for the job with the given jobId.
    JobPostsDataProvider.getJobPostsByJobID(jobId).then((jobPosts) {
      selectedJobPosts = jobPosts
          .map((jobPost) {
            return JobPost.fromMap(jobPost);
          })
          .where((jobPost) => jobPost != null)
          .cast<JobPost>()
          .toList();

      if (selectedJobPosts.isNotEmpty) {
        selectedJobPost = selectedJobPosts.first;
      }

      searchComplete = true;
      notifyListeners();
    });
  }

  Future<void> translateJobPosts(targetLanguage) async {
    List<JobPost> translatedJobPosts = [];
    if (selectedJobPostId.isNotEmpty) {
      translatedJobPosts = await JobPostsDataProvider.translateJobPosts(
          selectedJobPostId, targetLanguage);
      if (translatedJobPosts.isEmpty) {
        EasyLoading.showError('No Jobs Found with $targetLanguage');
        return;
      }
      selectedJobPosts = translatedJobPosts;
      selectedJobPost = translatedJobPosts.firstWhere((jobPost) {
        return jobPost.jobPostId == selectedJobPostId;
      }, orElse: () => translatedJobPosts.first);
      notifyListeners();
    }
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
      Navigator.pushNamed(context, '/createJobPost');
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
    print('newJobPostData: $newJobPostData');

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
    selectedJobPosts = [];
    selectedJobPosts =
        await JobPostsDataProvider.searchJobPosts(nameRelated, locationRelated);
    if (selectedJobPosts.isEmpty) {
      EasyLoading.showError('No Jobs Found with $nameRelated $locationRelated');
    } else {
      selectedJobPost = selectedJobPosts.first;
      isSearching = true;
      notifyListeners();
    }
  }

  void setSearching(bool bool) {
    isSearching = bool;
    notifyListeners();
  }

  bool isWebSearching = false;

  Future<void> getJobsBySearchParameter(
      String nameSearch, String locationSearch) async {
    List<JobPost> searchJobPosts =
        await JobPostsDataProvider.searchJobPosts(nameSearch, locationSearch);
    if (searchJobPosts.isEmpty) {
      EasyLoading.showError('No Jobs Found with $nameSearch $locationSearch');
    } else {
      searchJobPosts.forEach((element) {
        searchJobs[element.jobPostId] = element;
      });
      isWebSearching = true;
      notifyListeners();
    }
  }

  void get50LastestJobPosts() async {
    // Get the 50 most recent job posts.
    List<Map<String, dynamic>> jobPosts =
        await JobPostsDataProvider.getRecentJobPosts();

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
    List<Map<String, dynamic>> jobPosts =
        await JobPostsDataProvider.getRealJobPosts();

    realJobPosts = {};
    for (var jobPost in jobPosts) {
      if (jobPost['id'] != null) {
        JobPost? parsedJobPost = JobPost.fromMap(jobPost);
        if (parsedJobPost != null) {
          realJobPosts[jobPost['id']] = parsedJobPost;
        }
      }
    }

    if (realJobPosts.isNotEmpty) {
      selectedJobPost = realJobPosts.values.first;
    }

    notifyListeners();
  }

// Future<List<JobPost>> getSavedJobPostIds(String uid) {
  //   return JobPostsDataProvider.getSavedJobPostIds(uid)
  //       .then((ids) => JobPostsDataProvider.getJobPostsByCompanyIds(ids));
  // }
}
