import 'package:bulkers/models/app_user.dart';
import 'package:bulkers/views/company/my_job_posts_components/create_job_post_components/compensation_and_contract_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../data_providers/job_posts_data_provider.dart';
import '../models/address.dart';
import '../models/job_post.dart';
import '../views/common_views/please_login_dialog.dart';

class JobPostsProvider with ChangeNotifier {
  Map<String, JobPost> _jobPosts = {};
  Map<String, dynamic> newJobPostData = {};

  JobPost? selectedJobPost;

  Map<String, JobPost> get jobPosts => _jobPosts;

  List<JobPost> selectedJobPosts = [];
  int jobPostCurrentPageIndex = 0;
  String selectedJobPostId = '';

  void getJobPostsByJobID(String jobId) {
    selectedJobPostId = jobId;

    // Get all jobPosts for the job with the given jobId.
    JobPostsDataProvider.getJobPostsByJobID(jobId).then((jobPosts) {
      selectedJobPosts = jobPosts.map((jobPost) {
        return JobPost.fromMap(jobPost);
      }).toList();
      selectedJobPost = selectedJobPosts.first;
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
    createJopPost();
    setJobPostPageNext();
  }

  Future<void> createJopPost() async {
    print('newJobPostData: $newJobPostData');

    // make sure that the jobPost accepts JobPost Model
    JobPost jobPost = JobPost.fromMap(newJobPostData);
    jobPost.dateCreated = DateTime.now().millisecondsSinceEpoch;
    await JobPostsDataProvider.createJobPost(jobPost);
    notifyListeners();
    newJobPostData = {};
    jobPostCurrentPageIndex = 0;
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

  // Future<List<JobPost>> getSavedJobPostIds(String uid) {
  //   return JobPostsDataProvider.getSavedJobPostIds(uid)
  //       .then((ids) => JobPostsDataProvider.getJobPostsByCompanyIds(ids));
  // }
}
