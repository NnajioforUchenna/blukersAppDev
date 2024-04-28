part of 'user_provider.dart';

extension AuthenticationAuthorization on UserProvider {
  Future<void> signOut() async {
    await _auth.signOut();
    _appUser = null;
    notifyListeners();
  }

  Future<void> deleteUser(String uid) async {
    EasyLoading.show(
      status: 'Deleting your Account...',
      maskType: EasyLoadingMaskType.black,
    );

    //delete collection data
    await UserDataProvider.deleteUser(uid, _appUser!.userRole == "company");

    if (_user != null) {
      //delete user from firebase auth
      await _user!.delete();
    }

    //signout
    await signOut();

    EasyLoading.dismiss();
  }

  Future<void> registerUser(
      {required BuildContext context,
      required String email,
      required String password}) async {
    // Display a loading indicator with a message to the user.
    EasyLoading.show(
      status: 'Creating your Account...',
      maskType: EasyLoadingMaskType.black,
    );

    // Attempt to register the user.
    var result = await UserDataProvider.registerUser(email, password);

    // Check if the registration was successful.
    updateUserRecords(result, context);
  }

  Future<void> loginAppUser(
      {required BuildContext context,
      required String email,
      required String password}) async {
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

      // Request permission for notifications
      requestForNotificationPermission(_appUser);

      notifyListeners();

      // Dismiss the loading indicator.
      EasyLoading.dismiss();

      // Navigate to the home page.
      if (userRole == "worker") {
        context.go('/jobs');
      } else {
        context.go('/workers');
      }
    } else {
      // Print and display any errors that occurred during login.

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
      context.go('/login');
    } else {
      // Print and display any errors that occurred during the password reset attempt.
      print("Error: ${result['error']}");
      EasyLoading.dismiss();
      EasyLoading.showError(result['error'],
          duration: const Duration(seconds: 3));
    }
  }

  Future<void> updateNewUserRecords(Map<String, dynamic> result) async {
    print('I was called to update new user records');
    if (result['success']) {
      Map<String, dynamic> userData = {
        'uid': result['userCredential'].user!.uid,
        'email': result['userCredential'].user!.email,
        'isLoginInformation': true,
        'registeredAs': userRole,
        'userRole': userRole,
        'workerTimelineStep': 1,
        'companyTimelineStep': 1,
        'createdAt': DateTime.now().millisecondsSinceEpoch,
        'modifiedAt': DateTime.now().millisecondsSinceEpoch,
        // you can add other key-value pairs if needed
      };

      AppUser appUser = AppUser.fromMap(userData);

      // Set the _appUser
      _appUser = appUser;

      // Add to Shared Preferences
      UserSharedPreferencesServices.create(appUser);

      // Store the user data in the database.
      UserDataProvider.registerUserToDatabase(appUser);

      // Update the User Journey
      UserJourneyDataProvider.updateNewcomer(appUser.uid);

      // Request permission for notifications
      requestForNotificationPermission(_appUser);

      // Dismiss the loading indicator.
      EasyLoading.dismiss();

      // Proceed to the next registration page.
      setRegisterPageIndex();
    } else {
      // Print and display any errors that occurred during registration.
      EasyLoading.dismiss();
      EasyLoading.showError(result['error'],
          duration: const Duration(seconds: 3));
    }
  }

  Future<void> updateUserRecords(
      Map<String, dynamic> result, BuildContext context) async {
    if (result['success']) {
      print('The User UID is: ${result['userCredential'].user!.uid}');
      bool isUserRegistered = await UserDataProvider.isUserRegistered(
          result['userCredential'].user!.uid);

      print('This User have Registered: $isUserRegistered');

      if (isUserRegistered) {
        loginUserInApp(result, context);
      } else {
        updateNewUserRecords(result);
      }
    } else {
      EasyLoading.dismiss();
      EasyLoading.showError(result['error'],
          duration: const Duration(seconds: 3));
    }
  }

  Future<void> loginUserInApp(Map<String, dynamic> result, context) async {
    print('I was called to login user in app');
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

      // Request permission for notifications
      requestForNotificationPermission(_appUser);

      notifyListeners();

      // Dismiss the loading indicator.
      EasyLoading.dismiss();

      // Navigate to the home page.
      if (userRole == "worker") {
        print('I was called to navigate to jobs page');
        // context.push('/jobs');
        GoRouter.of(context).go('/jobs');
      } else {
        print('I was called to navigate to workers page');
        GoRouter.of(context).go('/workers');
        context.push('/workers');
      }
    } else {
      // Print and display any errors that occurred during login.

      EasyLoading.dismiss();
      EasyLoading.showError(result['error'],
          duration: const Duration(seconds: 3));
    }
  }
}
