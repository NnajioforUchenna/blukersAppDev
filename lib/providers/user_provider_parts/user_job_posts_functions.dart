part of 'user_provider.dart';

extension UserJobPostsFunctions on UserProvider {
  void updateTargetLanguage(String? newValue) {
    language = newValue ?? language;
    if (appUser != null) {
      UserDataProvider.updateUserBasicInfo(
          {"language": language}, appUser!.uid);
    }
    notifyListeners();
  }

  bool isJobPostApplied(String jobPostId) {
    return appUser?.workerRecords?.appliedJobPostIds.contains(jobPostId) ??
        false; // Change to JobPostId
  }

  bool isJobPostSaved(String jobPostId) {
    return appUser?.workerRecords?.savedJobPostIds.contains(jobPostId) ??
        false; // Change to JobPostId
  }

  saveJobPost(JobPost jobPost) {
  // Ensure workerRecords exist
  appUser?.workerRecords ??= WorkerRecords();

  // Check if the job post is already saved
  if (isJobPostSaved(jobPost.jobPostId)) {
    // Remove the job post from savedJobPostIds
    appUser?.workerRecords?.savedJobPostIds.remove(jobPost.jobPostId);
    EasyLoading.showSuccess('Job Post Removed');
  } else {
    // Add the job post to savedJobPostIds
    appUser?.workerRecords?.savedJobPostIds.add(jobPost.jobPostId);
    EasyLoading.showSuccess('Job Post Saved');
  }

  // Persist data to database
  UserDataProvider.updateUser(appUser!);
  UserDataProvider.updateWorkerSavedJobPostIds(
    appUser!.workerRecords!.savedJobPostIds!, appUser!.uid);
}


  Future<void> checkAndApplyJobPost(
      BuildContext context, JobPost jobPost) async {
    if (workerTimelineStep < 3) {
      showDialog(
          context: context,
          builder: (context) => const DisplayJobTimelineDialog());
    } else {
      bool? isEligible = appUser?.checkIfEligible();
      if (isEligible ?? false) {
        appUser?.updateNumOfJobsAppliedToday();
        applyForJobPost(jobPost);
      } else {
        showDialog(
            context: context,
            builder: (context) => const JobPostEligibilityDialog());
      }
    }
  }

  bool isWorkerSaved(String workerId) {
    return appUser?.company?.interestingWorkersIds.contains(workerId) ??
        false; // Change to JobPostId
  }
}
