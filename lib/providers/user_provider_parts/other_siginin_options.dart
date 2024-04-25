part of 'user_provider.dart';

extension OtherSignInOptions on UserProvider {
  Future<void> signInWithGoogle() async {
    // Attempt to sign in with Google.
    var result = await UserDataProvider.signInWithGoogle();
  }
}
