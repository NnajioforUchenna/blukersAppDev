part of 'user_provider.dart';

extension OtherSignInOptions on UserProvider {
  Future<void> signInWithGoogle(BuildContext context) async {
    // Attempt to sign in with Google.
    EasyLoading.show(
      status: 'Authenticating...',
      maskType: EasyLoadingMaskType.black,
    );
    AuthResult authResult = await UserDataProvider.signInWithGoogle();
    print('Signing in is done');
    print(authResult.toString());
    checkIfRegisteredOrLogin(authResult, context);
  }

  Future<void> signInWithApple(BuildContext context) async {
    // Attempt to sign in with Apple.
    AuthResult authResult = await UserDataProvider.signInWithApple();
    // Check if the registration was successful.
    checkIfRegisteredOrLogin(authResult, context);
  }

  Future<void> signInWithFacebook(BuildContext context) async {
    EasyLoading.show(
      status: 'Authenticating...',
      maskType: EasyLoadingMaskType.black,
    );
    // Attempt to sign in with Facebook.
    AuthResult authResult = await UserDataProvider.signInWithFacebook();
    // Check if the registration was successful.
    checkIfRegisteredOrLogin(authResult, context);
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
