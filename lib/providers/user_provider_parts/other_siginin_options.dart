part of 'user_provider.dart';

extension OtherSignInOptions on UserProvider {
  Future<void> signInWithGoogle(BuildContext context) async {
    // Attempt to sign in with Google.
    var result = await UserDataProvider.signInWithGoogle();
    updateUserRecords(result, context);
  }

  Future<void> signInWithApple(BuildContext context) async {
    // Attempt to sign in with Apple.
    var result = await UserDataProvider.signInWithApple();
    // Check if the registration was successful.
    updateUserRecords(result, context);
  }

  Future<void> signInWithFacebook(BuildContext context) async {
    // Attempt to sign in with Facebook.
    var result = await UserDataProvider.signInWithFacebook();
    // Check if the registration was successful.
    updateUserRecords(result, context);
  }
}
