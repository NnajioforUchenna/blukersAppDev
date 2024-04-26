part of 'user_provider.dart';

extension OtherSignInOptions on UserProvider {
  Future<void> signInWithGoogle() async {
    // Attempt to sign in with Google.
    var result = await UserDataProvider.signInWithGoogle();
  }

  Future<void> signInWithApple() async {
    // Attempt to sign in with Apple.
    var result = await UserDataProvider.signInWithApple();
  }

  Future<void> signInWithFacebook() async {
    // Attempt to sign in with Facebook.
    var result = await UserDataProvider.signInWithFacebook();
  }
}
