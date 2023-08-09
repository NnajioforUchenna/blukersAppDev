import 'package:bulkers/models/app_user.dart';
import 'package:bulkers/views/company/my_job_posts_components/create_job_post_components/compensation_and_contract_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../data_providers/job_posts_data_provider.dart';
import '../models/address.dart';
import '../models/job_post.dart';
import '../models/skill.dart';
import '../views/common_views/please_login_dialog.dart';

class JobPostsProvider with ChangeNotifier {
  Map<String, JobPost> _jobPosts = {};
  Map<String, dynamic> newJobPostData = {};

  JobPost? selectedJobPost;

  Map<String, JobPost> get jobPosts => _jobPosts;

  List<JobPost> selectedJobPosts = [];
  int jobPostCurrentPageIndex = 0;

  void getJobPostsByJobID(String jobId) {
    // Get all jobPosts for the job with the given jobId.
    print(jobId);
    JobPostsDataProvider.getJobPostsByJobID(jobId).then((jobPosts) {
      selectedJobPosts = jobPosts.map((jobPost) {
        return JobPost.fromMap(jobPost);
      }).toList();
      selectedJobPost = selectedJobPosts.first;
      notifyListeners();
    });
  }

  void setSelectedJobPost(JobPost jobPost) {
    selectedJobPost = jobPost;
    notifyListeners();
  }

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
    print(jobId);
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
    newJobPostData['jobTitle'] = title;
    newJobPostData['jobDescription'] = description;
    newJobPostData['numberOfPositionsAvailable'] = positionsAvailable;
    newJobPostData['jobUrgencyLevel'] = urgencyValue;
    setJobPostPageNext();
  }

  void addQualificationAndSkills(
      String requirement, List<String> selectedSkillNames) {
    newJobPostData['requirements'] = requirement;
    List skillsAsMaps = selectedSkillNames
        .map((skillName) => Skill(id: skillName, name: skillName).toMap())
        .toList();
    newJobPostData['skills'] = skillsAsMaps;
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
