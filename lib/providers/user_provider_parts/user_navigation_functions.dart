part of 'user_provider.dart';

extension UserNavigationFunctions on UserProvider {
  void updateNavigationVariables() {
    userRole = _appUser?.userRole;
    companyTimelineStep = _appUser?.companyTimelineStep ?? 0;
    workerTimelineStep = _appUser?.workerTimelineStep ?? 0;
  }

  void setJobTimelineStep(int step) {
    _appUser!.workerTimelineStep = step;
    UserDataProvider.updateTimelineStep(_appUser!.uid, step);
  }

  void setRegisterPageIndex() {
    registerCurrentPageIndex++;
    notifyListeners();
    pageController.nextPage(
        duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
  }

  void navigate(BuildContext context, int index) {
    currentPageIndex = index;
    notifyListeners();
    String targetRoute =
        userRole == "company" ? routesCompany[index] : routesWorker[index];
    context.pushReplacement(targetRoute);
  }

  void navigateCompany(BuildContext context, int index) {
    currentPageIndex = index;
    notifyListeners();
    context.go(routesCompany[index]);
  }

  void navigateMessenger(BuildContext context, int index) {
    messengerIndex = index;
    notifyListeners();
  //  context.go(routesMessenger[index]);
  }

  void navigateWorker(BuildContext context, int index) {
    currentPageIndex = index;
    notifyListeners();
    context.go(routesWorker[index]);
  }

  void updateNavigationIndex(int index) {
    currentPageIndex = index;
    notifyListeners();
  }

  void navigateBasedOnRole(BuildContext context) {
    if (userRole == "worker") {
      context.go('/jobs');
    } else {
      context.go('/workers');
    }
  }
}
