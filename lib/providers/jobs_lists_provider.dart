import 'package:blukers/models/app_user/components/preference.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../data_providers/jobs_lists_data_provider.dart';
import '../models/app_user/app_user.dart';
import '../models/job_post.dart';
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
  }

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

  fillDisplayJobsByPreferences() async {
    // Fetch the jobs by preferences and update the displayJobsByPreferences map
    Preference? preference = appUser?.registrationDetails?.jobsPreference;
    if (preference != null) {
      displayJobsByPreferences.clear();
      displayJobsByPreferences =
          await JobsListsDataProvider.getJobsByPreferences(preference);
      notifyListeners();
    } else {
      // Display Error that no preferences are set
      EasyLoading.showError('No Preferences are set');
    }
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
