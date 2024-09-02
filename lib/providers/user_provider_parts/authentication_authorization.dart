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
    AuthResult authResult =
        await UserDataProvider.registerUser(email, password);

    // Follow the registration flow.
    followRegistrationFlow(authResult, context);
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
    AuthResult authResult = await UserDataProvider.loginUser(email, password);

    // Follow the login flow.
    followLoginFlow(authResult, context);
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

  void followRegistrationFlow(AuthResult authResult, BuildContext context) {
    if (authResult.isSuccess) {
      // Track the registration status.
      RegistrationStatus status = RegistrationStatus();
      status.isLoginInformation = true;

      // Store registration details.
      RegistrationDetails registrationDetails = RegistrationDetails(
        email: authResult.userCredential?.user!.email ?? '',
        status: status,
        registeredAs: userRole,
      );

      Map<String, dynamic> userData = {
        'uid': authResult.userCredential?.user!.uid,
        'email': authResult.userCredential?.user!.email,
        'registrationDetails': registrationDetails.toMap(),
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
      EasyLoading.showError(authResult.message!,
          duration: const Duration(seconds: 3));
    }
  }

  Future<void> followLoginFlow(
      AuthResult authResult, BuildContext context) async {
    if (authResult.isSuccess) {
      AppUser? appUser4DB = await UserDataProvider.getAppUser(
          authResult.userCredential?.user!.uid);

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
        GoRouter.of(context).go('/jobs');
      } else {
        GoRouter.of(context).go('/workers');
      }
    } else {
      // Print and display any errors that occurred during login.
      EasyLoading.dismiss();
      EasyLoading.showError(authResult.message!,
          duration: const Duration(seconds: 3));
    }
  }
}
