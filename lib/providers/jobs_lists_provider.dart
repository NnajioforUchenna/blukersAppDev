import 'package:blukers/models/app_user/components/preference.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../data_providers/job_posts_data_provider.dart';
import '../data_providers/jobs_lists_data_provider.dart';
import '../models/app_user/app_user.dart';
import '../models/job_post.dart';
import '../models/jobs_models/jobs_page_by_preferences.dart';
import '../models/jobs_page.dart';

class JobsListsProvider extends ChangeNotifier {
  AppUser? appUser;
  String language = 'en';
  JobPost? selectedJobPost;

  update(AppUser? user) {
    appUser = user;
    if (appUser != null && appUser!.language != null) {
      language = appUser!.language ?? 'en';
    }
    notifyListeners();
  }

  JobsListsProvider() {
    fillDisplayAllJobs();
    fillDisplayJobsByPreferences();
  }

  //____________________________________________________________________________________Saved Jobs
  Map<String, JobPost> savedJobPosts = {};

  Future<void> getSavedJobPostByIds() async {
    // check appUser.workerRecords.savedJobPostIds
    if (appUser?.workerRecords?.savedJobPostIds != null) {
      List<JobPost> listJobPosts =
          await JobPostsDataProvider.getJobPostsByCompanyIds(
              appUser!.workerRecords!.savedJobPostIds);
      savedJobPosts = {for (var e in listJobPosts) e.jobPostId: e};
      notifyListeners();
    }
  }

  //____________________________________________________________________________________End of Saved Jobs

  //____________________________________________________________________________________Applied Jobs
  Map<String, JobPost> appliedJobPosts = {};

  Future<void> getAppliedJobPostByIds() async {
    // check appUser.workerRecords.appliedJobPostIds
    if (appUser?.workerRecords?.appliedJobPostIds != null) {
      List<JobPost> listJobPosts =
          await JobPostsDataProvider.getJobPostsByCompanyIds(
              appUser!.workerRecords!.appliedJobPostIds);
      appliedJobPosts = {for (var e in listJobPosts) e.jobPostId: e};
      notifyListeners();
    }
  }

  //____________________________________________________________________________________End of Applied Jobs

  //____________________________________________________________________________________All Jobs
  // Parameters for Displaying All Jobs
  bool hasMore = true;
  JobsPage jobsPage = JobsPage();
  Map<String, JobPost> displayAllJobs = {};

  Future<void> fillDisplayAllJobs() async {
    // Fetch the next page of jobs and update the jobs page
    jobsPage = await JobsListsDataProvider.getAllJobsAtPage(jobsPage);

    // Update the displayAllJobs map with the new jobs
    for (JobPost job in jobsPage.jobs) {
      displayAllJobs[job.jobPostId] = job;
    }

    // Notify listeners to update the UI
    notifyListeners();
  }

  loadMoreAllJobs() async {
    // Fetch the next page of jobs and update the jobs page
    jobsPage = await JobsListsDataProvider.getAllJobsAtPage(jobsPage);

    // Update  hasMore
    hasMore = jobsPage.jobs.isNotEmpty;

    // Update the displayAllJobs map with the new jobs
    Map<String, JobPost> newJobs = {};

    for (JobPost job in jobsPage.jobs) {
      newJobs[job.jobPostId] = job;
    }

    return newJobs;
  }
  //____________________________________________________________________________________End of All Jobs

//____________________________________________________________________________________Jobs By Preferences
  Map<String, JobPost> displayJobsByPreferences = {};
  JobsPageByPreferences jobsPageByPreferences = JobsPageByPreferences();
  bool hasMorePreferences = true;

  fillDisplayJobsByPreferences() async {
    // Fetch the jobs by preferences and update the displayJobsByPreferences map
    Preference? preference = appUser?.registrationDetails?.jobsPreference;
    if (preference != null) {
      jobsPageByPreferences = JobsPageByPreferences();
      jobsPageByPreferences.preference = preference;
      jobsPageByPreferences.language = language;
      jobsPageByPreferences = await JobsListsDataProvider.getJobsByPreferences(
          jobsPageByPreferences);

      if (jobsPageByPreferences.jobs.isNotEmpty) {
        displayJobsByPreferences.clear();
        // Update the displayJobsByPreferences map with the new jobs
        for (JobPost job in jobsPageByPreferences.jobs) {
          displayJobsByPreferences[job.jobPostId] = job;
        }
      }
      notifyListeners();
    } else {
      // Display Error that no preferences are set
      EasyLoading.showError('No Preferences are set');
    }
  }

  loadMoreJobsByPreferences() async {
    // Fetch the next page of jobs and update the jobs page
    jobsPageByPreferences =
        await JobsListsDataProvider.getJobsByPreferences(jobsPageByPreferences);

    // Update  hasMore
    hasMorePreferences = jobsPageByPreferences.jobs.isNotEmpty;

    // Update the displayJobsByPreferences map with the new jobs
    Map<String, JobPost> newJobs = {};

    for (JobPost job in jobsPageByPreferences.jobs) {
      newJobs[job.jobPostId] = job;
    }

    return newJobs;
  }

  //____________________________________________________________________________________End of Jobs By Preferences

  //____________________________________________________________________________________Jobs By Search
  Map<String, JobPost> displayJobsBySearch = {};
  // Search Parameters
  String nameSearch = '';
  String locationSearch = '';
  int pageNumberOfSearch = 0;

  //____________________________________________________________________________________End of Jobs By Search

  //____________________________________________________________________________________Jobs By JobId
  Map<String, JobPost> displayJobsByJobId = {};

  //____________________________________________________________________________________End of Jobs By JobId
}
