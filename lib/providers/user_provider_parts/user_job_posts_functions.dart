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
    return appUser?.worker?.appliedJobPostIds?.contains(jobPostId) ??
        false; // Change to JobPostId
  }

  bool isJobPostSaved(String jobPostId) {
    return appUser?.worker?.savedJobPostIds?.contains(jobPostId) ??
        false; // Change to JobPostId
  }

  Future<void> checkAndApplyJobPost(
      BuildContext context, JobPost jobPost) async {
    if (workerTimelineStep < 2) {
      showDialog(
          context: context,
          builder: (context) => const DisplayJobTimelineDialog());
    } else {
      bool result = await checkIfSubscribed();
      if (!result) {
        showDialog(
            context: context,
            builder: (context) => const ShowSubscriptionDialog());
      } else {
        bool? isEligible = appUser?.checkIfEligible();

        if (isEligible ?? false) {
          appUser?.updateNumOfJobsAppliedToday();
          print("${appUser?.jobApplicationTracker?.toMap()}");
          applyForJobPost(jobPost);
        } else {
          showDialog(
              context: context,
              builder: (context) => const JobPostEligibilityDialog());
        }
      }
    }
  }

  void saveJobPost(JobPost jobPost) {
    // Update UI interFace
    appUser?.worker?.savedJobPostIds?.add(jobPost!.jobPostId!);
    notifyListeners();
    // Persist data to database
    UserDataProvider.updateWorkerSavedJobPostIds(
        appUser!.worker!.savedJobPostIds!, appUser!.uid);
  }

  bool isWorkerSaved(String workerId) {
    return appUser?.company?.interestingWorkersIds.contains(workerId) ??
        false; // Change to JobPostId
  }
}
