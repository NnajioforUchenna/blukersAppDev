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
    return appUser?.workerRecords?.appliedJobPostIds?.contains(jobPostId) ??
        false; // Change to JobPostId
  }

  bool isJobPostSaved(String jobPostId) {
    return appUser?.workerRecords?.savedJobPostIds?.contains(jobPostId) ??
        false; // Change to JobPostId
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

  void saveJobPost(JobPost jobPost) {
    // Update UI interFace
    appUser?.workerRecords?.savedJobPostIds?.add(jobPost.jobPostId);
    notifyListeners();
    // Persist data to database
    UserDataProvider.updateWorkerSavedJobPostIds(
        appUser!.workerRecords!.savedJobPostIds!, appUser!.uid);
  }

  bool isWorkerSaved(String workerId) {
    return appUser?.company?.interestingWorkersIds.contains(workerId) ??
        false; // Change to JobPostId
  }
}
