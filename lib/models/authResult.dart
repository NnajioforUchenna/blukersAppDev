import 'package:firebase_auth/firebase_auth.dart';

class AuthResult {
  final UserCredential? userCredential;
  final bool isSuccess;
  final String? message;

  AuthResult({
    this.userCredential,
    required this.isSuccess,
    this.message,
  });

  factory AuthResult.isSuccess(UserCredential userCredential) {
    return AuthResult(
      userCredential: userCredential,
      isSuccess: true,
    );
  }

  factory AuthResult.failure(String message) {
    return AuthResult(
      isSuccess: false,
      message: message,
    );
  }

  @override
  String toString() {
    return 'AuthResult{userCredential: $userCredential, isSuccess: $isSuccess, message: $message}';
  }
}
