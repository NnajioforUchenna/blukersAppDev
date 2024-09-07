import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRecipientListModel {
  final String uid;
  final String displayName;
  final String email;
  final String photoUrl;
  final Timestamp lastMessageTimestamp; // Timestamp when the last message was sent
  int unreadMessageCount; // Added property for unread message count

  // Constructor
  ChatRecipientListModel({
    required this.uid,
    required this.displayName,
    required this.email,
    required this.photoUrl,
    required this.lastMessageTimestamp,
    this.unreadMessageCount = 0, // Default unread message count to 0
  });

  // Factory constructor for creating an instance from a map
  factory ChatRecipientListModel.fromMap(Map<String, dynamic> map) {
    return ChatRecipientListModel(
      uid: map['uid'] ?? '',
      displayName: map['displayName'] ?? '',
      email: map['email'] ?? '',
      photoUrl: map['photoUrl'] ?? '',
      lastMessageTimestamp : map['lasMessageTimeStamp'],
      unreadMessageCount: map['unreadMessageCount'] ??
          0, // Assign unread message count if available, else default to 0
    );
  }

  // Method to convert an instance to a map
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'displayName': displayName,
      'email': email,
      'photoUrl': photoUrl,
      'lasMessageTimeStamp' : lastMessageTimestamp,
      'unreadMessageCount':
      unreadMessageCount, // Include unread message count in the map
    };
  }
}
