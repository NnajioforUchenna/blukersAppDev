part of 'user_provider.dart';

extension UserNavigationFunctions on UserProvider {
  void updateNavigationVariables() {
    userRole = _appUser!.userRole;
    companyTimelineStep = _appUser!.companyTimelineStep!;
    workerTimelineStep = _appUser!.workerTimelineStep!;
  }

  void setJobTimelineStep(int step) {
    _appUser!.workerTimelineStep = step;
    UserDataProvider.updateTimelineStep(_appUser!.uid, step);
  }

  void setRegisterPageIndex() {
    registerCurrentPageIndex++;
    notifyListeners();
  }

  void navigate(BuildContext context, int index) {
    currentPageIndex = index;
    String targetRoute =
        userRole == "company" ? routesCompany[index] : routesWorker[index];
    context.go(targetRoute);
  }

  void navigateBasedOnRole(BuildContext context) {
    if (userRole == "worker") {
      context.go('/jobs');
    } else {
      context.go('/workers');
    }
  }
}