part of "../user_provider.dart";

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

  void applyForJobPost(JobPost jobPost) {
    print(jobPost.toString());
    // Update UI interFace
    appUser?.worker?.appliedJobPostIds?.add(jobPost!.jobPostId!);
    notifyListeners();
    // Persist data to database
    UserDataProvider.updateWorkerAppliedJobPostIds(
        appUser!.worker!.appliedJobPostIds!, appUser!.uid);
    // update JobPost Records
    JobPostsDataProvider.updateJobPostAppliedWorkerIds(
        jobPost!.jobPostId!, appUser!.uid);
  }

  bool isJobPostSaved(String jobPostId) {
    return appUser?.worker?.savedJobPostIds?.contains(jobPostId) ??
        false; // Change to JobPostId
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
