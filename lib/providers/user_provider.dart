import 'package:bulkers/data_providers/user_data_provider.dart';
import 'package:bulkers/models/job_post.dart';
import 'package:bulkers/providers/chat_provider.dart';
import 'package:bulkers/services/user_shared_preferences_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../common_files/constants.dart';
import '../data_providers/job_posts_data_provider.dart';
import '../models/address.dart';
import '../models/app_user.dart';
import '../models/company.dart';
import '../models/worker.dart';

class UserProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? _user;
  User? get user => _user;

  AppUser? _appUser;
  AppUser? get appUser => _appUser;

  // Navigation Controls
  String userRole = "company";
  int jobTimelineStep = 0;

  switchUserRole() {
    if (userRole == "company") {
      userRole = "worker";
    } else {
      userRole = "company";
    }
    notifyListeners();
  }

  int registerCurrentPageIndex = 0;

  UserProvider() {
    _auth.authStateChanges().listen((User? user) {
      _user = user;
      if (user != null) {
        initializeAppUser(user.uid);
      }
      notifyListeners();
    });
  }

  Future<void> initializeAppUser(uid) async {
    _appUser = await UserDataProvider.getAppUser(uid);
    if (_appUser!.userRole == "company") {
      userRole = "company";
    } else {
      userRole = "worker";
    }
    if (_appUser!.timelineStep != null) {
      jobTimelineStep = _appUser!.timelineStep!;
    }
    notifyListeners();
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  void setJobTimelineStep(int step) {
    jobTimelineStep = step;
    notifyListeners();
    UserDataProvider.updateTimelineStep(_appUser!.uid, step);
  }

  int currentPageIndex = 0;

  void setRegisterPageIndex() {
    registerCurrentPageIndex++;
    notifyListeners();
  }

  Future<void> registerUser(
      {required String email,
      required String password,
      required String userType,
      required ChatProvider chatProvider}) async {
    // Display a loading indicator with a message to the user.
    EasyLoading.show(
      status: 'Creating your Account...',
      maskType: EasyLoadingMaskType.black,
    );

    // Attempt to register the user.
    var result = await UserDataProvider.registerUser(email, password);

    // Check if registration was successful.
    if (result['success']) {
      // Prepare the user data for storage.
      AppUser appUser = AppUser.fromSignUp(
          uid: result['userCredential'].user!.uid,
          email: email,
          isLoginInformation: true,
          registeredAs: userType,
          userRole: userType,
          timelineStep: 1);

      // Set the _appUser
      _appUser = appUser;

      // Add to Shared Preferences
      UserSharedPreferencesServices.create(appUser);

      // Store the user data in the database.
      UserDataProvider.registerUserToDatabase(appUser);
      //
      // await NotificationService.registerNotification(
      //     _appUser!.uid, chatProvider);
      // NotificationService.configLocalNotification();
      // Dismiss the loading indicator.
      EasyLoading.dismiss();

      // Proceed to the next registration page.
      setRegisterPageIndex();
    } else {
      // Print and display any errors that occurred during registration.
      print("Error: ${result['error']}");
      EasyLoading.dismiss();
      EasyLoading.showError(result['error'],
          duration: const Duration(seconds: 3));
    }
  }

  void updateWorker(
      {required String name,
      required String lastName,
      required String description}) {
    EasyLoading.show(
      status: 'Adding Basic Information...',
      maskType: EasyLoadingMaskType.black,
    );
    Worker worker = Worker.fromSignUp(
      workerId: appUser!.uid,
      lastName: lastName,
      firstName: name,
      email: appUser!.email!,
      workerBriefDescription: description,
    );
    UserDataProvider.updateWorkerBasicInformation(worker);
    _appUser!.worker = worker;
    _appUser!.isBasicInformation = true;
    EasyLoading.dismiss();
    setRegisterPageIndex();
  }

  void updateCompany(
      {required String companyName, required String description}) {
    EasyLoading.show(
      status: 'Adding Basic Information...',
      maskType: EasyLoadingMaskType.black,
    );
    Company company = Company.fromSignUp(
      companyId: appUser!.uid,
      companyDescription: description,
      name: companyName,
      emails: [appUser!.email!],
    );
    UserDataProvider.updateBasicInformation(company);
    _appUser!.company = company;
    _appUser!.isBasicInformation = true;
    EasyLoading.dismiss();
    setRegisterPageIndex();
  }

  void addingContactInformation(String ext, String phoneNumber, String street,
      String city, String state, String postalCode, String country) {
    EasyLoading.show(
      status: 'Adding Contact Information...',
      maskType: EasyLoadingMaskType.black,
    );

    Address address = Address(
        street: street,
        city: city,
        state: state,
        postalCode: postalCode,
        country: country);

    String completePhoneNumber = ext + phoneNumber;

    UserDataProvider.updateContactInformation(
        completePhoneNumber, address, appUser!.uid);

    _appUser!.address = address;
    _appUser!.phoneNumber = completePhoneNumber;
    _appUser!.isContactInformation = true;

    EasyLoading.dismiss();
    setRegisterPageIndex();
  }

  void navigate(BuildContext context, int index) {
    currentPageIndex = index;
    if (userRole == "worker") {
      Navigator.pushNamedAndRemoveUntil(
          context, routesWorker[index], (Route<dynamic> route) => false);
    } else {
      Navigator.pushNamedAndRemoveUntil(
          context, routesCompany[index], (Route<dynamic> route) => false);
    }

    // notifyListeners();
  }

  Future<void> loginAppUser(
      {required BuildContext context,
      required String email,
      required String password,
      required ChatProvider chatProvider}) async {
    // Display a loading indicator with a message to the user.
    EasyLoading.show(
      status: 'Logging you in...',
      maskType: EasyLoadingMaskType.black,
    );

    // Attempt to log the user in.
    var result = await UserDataProvider.loginUser(email, password);

    // Check if the login was successful.
    if (result['success']) {
      // Fetch user details from the database or wherever necessary.
      // This step assumes that you have a method to get user details after they log in.
      AppUser? appUser4DB =
          await UserDataProvider.getAppUser(result['userCredential'].user!.uid);

      // Set the _appUser
      _appUser = appUser4DB;

      // Add to Shared Preferences
      if (appUser4DB != null) {
        UserSharedPreferencesServices.create(appUser4DB);
      }

      // await NotificationService.registerNotification(
      //     _appUser!.uid, chatProvider);
      // NotificationService.configLocalNotification();
      notifyListeners();

      // Dismiss the loading indicator.
      EasyLoading.dismiss();

      // Navigate to the home page.
      if (userRole == "worker") {
        Navigator.pushNamedAndRemoveUntil(
            context, '/jobs', (Route<dynamic> route) => false);
      } else {
        Navigator.pushNamedAndRemoveUntil(
            context, '/workers', (Route<dynamic> route) => false);
      }
    } else {
      // Print and display any errors that occurred during login.
      print("Error: ${result['error']}");
      EasyLoading.dismiss();
      EasyLoading.showError(result['error'],
          duration: const Duration(seconds: 3));
    }
  }

  Future<void> resetAppUserPassword({
    required BuildContext context,
    required String email,
  }) async {
    // Display a loading indicator with a message to the user.
    EasyLoading.show(
      status: 'Sending password reset link...',
      maskType: EasyLoadingMaskType.black,
    );

    // Attempt to send a password reset email.
    var result = await UserDataProvider.resetPassword(email);

    // Check if the reset link was sent successfully.
    if (result['success']) {
      // Dismiss the loading indicator.
      EasyLoading.dismiss();
      notifyListeners();

      // Show success message.
      EasyLoading.showSuccess(
        result['message'],
        duration: const Duration(seconds: 3),
      );
      Navigator.pushNamedAndRemoveUntil(
          context, '/login', (Route<dynamic> route) => false);
    } else {
      // Print and display any errors that occurred during the password reset attempt.
      print("Error: ${result['error']}");
      EasyLoading.dismiss();
      EasyLoading.showError(result['error'],
          duration: const Duration(seconds: 3));
    }
  }

  isJobPostApplied(String jobPostId) {
    return appUser?.worker?.appliedJobPostIds?.contains(jobPostId) ??
        false; // Change to JobPostId
  }

  void applyForJobPost(JobPost jobPost) {
    print(jobPost.toString());
    // Update UI interFace
    appUser?.worker?.appliedJobPostIds
        ?.add(jobPost.companyId); // Todo Change companyId to jobPostId
    notifyListeners();
    // Persist data to database
    UserDataProvider.updateWorkerAppliedJobPostIds(
        appUser!.worker!.appliedJobPostIds!, appUser!.uid);
    // update JobPost Records
    JobPostsDataProvider.updateJobPostAppliedWorkerIds(
        jobPost.companyId, appUser!.uid); // Todo Change companyId to jobPostId
  }

  bool isJobPostSaved(String jobPostId) {
    return appUser?.worker?.savedJobPostIds?.contains(jobPostId) ??
        false; // Change to JobPostId
  }

  void saveJobPost(JobPost jobPost) {
    // Update UI interFace
    appUser?.worker?.savedJobPostIds
        ?.add(jobPost.companyId); // Todo Change companyId to jobPostId
    notifyListeners();
    // Persist data to database
    UserDataProvider.updateWorkerSavedJobPostIds(
        appUser!.worker!.savedJobPostIds!, appUser!.uid);
// Todo Change companyId to jobPostId
  }
}
