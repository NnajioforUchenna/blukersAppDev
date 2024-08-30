part of 'user_provider.dart';

extension OtherSignInOptions on UserProvider {
  Future<void> signInWithGoogle(BuildContext context) async {
    // Attempt to sign in with Google.
    try {
      EasyLoading.show(
        status: 'Authenticating...',
        maskType: EasyLoadingMaskType.black,
      );
      AuthResult authResult = await UserDataProvider.signInWithGoogle();
      log(authResult.isSuccess.toString());
      checkIfRegisteredOrLogin(authResult, context);
    } catch (e) {
      EasyLoading.dismiss();
    }
  }

  Future<void> signInWithApple(BuildContext context) async {
    // Attempt to sign in with Apple.
    AuthResult authResult = await UserDataProvider.signInWithApple();
    // Check if the registration was successful.
    checkIfRegisteredOrLogin(authResult, context);
  }

  Future<void> signInWithFacebook(BuildContext context) async {
    try {
      EasyLoading.show(
        status: 'Authenticating...',
        maskType: EasyLoadingMaskType.black,
      );
      // Attempt to sign in with Facebook.
      AuthResult authResult = await UserDataProvider.signInWithFacebook();
      // Check if the registration was successful.
      checkIfRegisteredOrLogin(authResult, context);
    } catch (e) {
      EasyLoading.dismiss();
    }
  }

  checkIfRegisteredOrLogin(AuthResult authResult, BuildContext context) {
    if (authResult.isSuccess) {
      // Check if the user is already registered.
      if (authResult.userCredential!.additionalUserInfo!.isNewUser) {
        followRegistrationFlow(authResult, context);
      } else {
        followLoginFlow(authResult, context);
      }
    } else {
      EasyLoading.dismiss();
    }
  }
}
