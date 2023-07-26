class AppUser {
  final String uid;
  final String? email; // Made nullable
  final String? language; // Made nullable
  final String? displayName; // Made nullable
  final String? phoneNumber; // Made nullable
  final String? photoUrl; // Made nullable
  final bool? isEmailVerified; // Already nullable

  AppUser({
    required this.uid,
    this.email,
    this.language,
    this.displayName,
    this.phoneNumber,
    this.photoUrl,
    this.isEmailVerified,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'language': language,
      'displayName': displayName,
      'phoneNumber': phoneNumber,
      'photoUrl': photoUrl,
      'isEmailVerified': isEmailVerified,
    };
  }

  static AppUser fromMap(Map<String, dynamic> map) {
    return AppUser(
      uid: map['uid'],
      email: map['email'],
      language: map['language'],
      displayName: map['displayName'],
      phoneNumber: map['phoneNumber'],
      photoUrl: map['photoUrl'],
      isEmailVerified: map['isEmailVerified'],
    );
  }

  @override
  String toString() {
    return toMap().toString();
  }
}
