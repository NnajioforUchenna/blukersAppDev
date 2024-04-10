class ChatRecipient {
  String uid;
  String displayName;
  String email;
  String photoUrl;
  String clientType;

  // Constructor
  ChatRecipient({
    required this.uid,
    required this.displayName,
    required this.email,
    required this.photoUrl,
    required this.clientType,
  });

  // Factory constructor for creating an instance from a map
  factory ChatRecipient.fromMap(Map<String, dynamic> map) {
    return ChatRecipient(
      uid: map['uid'] ?? '',
      displayName: map['displayName'] ?? '',
      email: map['email'] ?? '',
      photoUrl: map['photoUrl'] ?? '',
      clientType: map['clientType'] ?? '',
    );
  }

  // Method to convert an instance to a map
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'displayName': displayName,
      'email': email,
      'photoUrl': photoUrl,
      'clientType': clientType,
    };
  }
}
