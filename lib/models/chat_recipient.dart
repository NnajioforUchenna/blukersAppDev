import 'package:blukers/models/app_user/app_user.dart';
import 'package:blukers/models/worker.dart';

class ChatRecipient {
  final String uid;
  final String displayName;
  final String email;
  final String photoUrl;
  final String clientType;
  int unreadMessageCount; // Added property for unread message count

  // Constructor
  ChatRecipient({
    required this.uid,
    required this.displayName,
    required this.email,
    required this.photoUrl,
    required this.clientType,
    this.unreadMessageCount = 0, // Default unread message count to 0
  });

  // Factory constructor for creating an instance from a map
  factory ChatRecipient.fromMap(Map<String, dynamic> map) {
    return ChatRecipient(
      uid: map['uid'] ?? '',
      displayName: map['displayName'] ?? '',
      email: map['email'] ?? '',
      photoUrl: map['photoUrl'] ?? '',
      clientType: map['clientType'] ?? '',
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
      'clientType': clientType,
      'unreadMessageCount':
          unreadMessageCount, // Include unread message count in the map
    };
  }

  // Static method to create a ChatRecipient from a Worker
  static ChatRecipient fromWorker(Worker worker) {
    return ChatRecipient(
      uid: worker.workerId,
      displayName: worker.getDisplayName(),
      email: worker.emails.firstOrNull ?? '',
      photoUrl: worker.workerResumeDetails?.profilePhotoUrl ?? '',
      clientType: 'worker',
    );
  }

  static ChatRecipient fromAppUser(AppUser appUser) {
    return ChatRecipient(
      uid: appUser.uid,
      displayName: appUser.displayName ?? '',
      email: appUser.registrationDetails?.email ?? '',
      photoUrl: appUser.photoUrl ?? '',
      clientType: appUser.userRole ?? '',
    );
  }
}
