import 'package:blukers/data_providers/push_notification.dart';
import 'package:blukers/models/chat_recipient.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/app_user/app_user.dart';
import '../models/chat_message.dart';
import '../models/chat_room.dart';

final firestore = FirebaseFirestore.instance;

class ChatDataProvider {
  static createChatRoom(
      {required String myUid,
      required String recipientUid,
      required String myName,
      required String recipientName,
      required String message,
      String myLogo = "",
      String recipientLogo = ""}) async {
    DocumentReference chatRoomDocRef = firestore.collection('ChatRooms').doc();
    ChatRoom chatRoom = ChatRoom(
        id: chatRoomDocRef.id,
        names: [myName, recipientName],
        lastMessage: message,
        chatLogo: [myLogo, recipientLogo],
        members: [myUid, recipientUid]);
    await chatRoomDocRef.set(chatRoom.toMap()).catchError((error) {
      print("Error adding worker_chat room to Firestore: $error");
    });
    return chatRoom;
  }

  static fetchGroupsByUserId(String uid) async {
    List<Map<String, dynamic>> res = [];
    var snapshot = await firestore
        .collection('ChatRooms')
        .where("members", arrayContains: uid)
        .get();
    for (int i = 0; i < snapshot.docs.length; i++) {
      //print(snapshot.docs[i].data());
      res.add(snapshot.docs[i].data());
    }
    return res;
  }

  static sendMessage(
      {required ChatMessage chatMessage,
      required String roomId,
      required String sentByName,
      required String sentToId}) async {
    await firestore
        .collection('ChatMessages')
        .doc(roomId)
        .collection('messages')
        .add(chatMessage.toMap());

    DataNotificationProvider.sendPushNotification(
        title: '$sentByName sent you a message',
        body: chatMessage.message,
        uid: sentToId);
  }

  static updateLastMEssage(String chatMessage, String roomId) async {
    await firestore
        .collection('ChatRooms')
        .doc(roomId)
        .update({"lastMessage": chatMessage});
  }

  static Stream<QuerySnapshot> fetchMessagesByGroupId(String groupId) {
    return firestore
        .collection('ChatMessages')
        .doc(groupId.trim())
        .collection('messages')
        .orderBy('sentAt')
        .snapshots();
  }

  static Stream<List<ChatRecipient>> getChatRecipientsStream(String uid) {
    return firestore
        .collection('ChatLists')
        .doc(uid)
        .collection('CompanyChatLists')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => ChatRecipient.fromMap(doc.data()))
            .toList());
  }

  // static Stream<List<ChatRecipient>> getChatRecipientsStream(String uid) {
  //   return firestore
  //       .collection('chat')
  //       .doc(uid)
  //       .collection('chat-recipients')
  //       .snapshots()
  //       .map((snapshot) => snapshot.docs
  //       .map((doc) => ChatRecipient.fromMap(doc.data()))
  //       .toList());
  // }

  static Future<int> getUnreadMessageCount(
      String currentUserUid, String recipientUid) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('chat')
        .doc(currentUserUid)
        .collection('messages')
        .doc(recipientUid)
        .collection('messages')
        .where('recipientId', isEqualTo: currentUserUid)
        .where('isRead', isEqualTo: false)
        .get();

    return querySnapshot.docs.length;
  }

  static void sendChat(String message, AppUser currentUser,
      ChatRecipient selectedChatRecipient) async {
    // Step 1: List the Recipient in the sender's worker_chat Recipients
    await firestore
        .collection('chat')
        .doc(currentUser.uid)
        .collection('chat-recipients')
        .doc(selectedChatRecipient.uid)
        .set(selectedChatRecipient.toMap());

    // Step 2: add message to the sender's worker_chat messages
    await firestore
        .collection('chat')
        .doc(currentUser.uid)
        .collection('messages')
        .doc(selectedChatRecipient.uid)
        .collection('messages')
        .add({
      'message': message,
      'senderId': currentUser.uid,
      'recipientId': selectedChatRecipient.uid,
      'timestamp': FieldValue.serverTimestamp()
    });

    // Step 3: List the Sender in the Recipient's worker_chat Recipients
    await firestore
        .collection('chat')
        .doc(selectedChatRecipient.uid)
        .collection('chat-recipients')
        .doc(currentUser.uid)
        .update({
      "clientType": currentUser.userRole,
      "displayName": currentUser.displayName,
      "email": currentUser.email,
      "photoUrl": currentUser.photoUrl,
      "uid": currentUser.uid,
      "unreadMessageCount": FieldValue.increment(1),
    });

    // Step 4: add message to the Recipient's worker_chat messages
    await firestore
        .collection('chat')
        .doc(selectedChatRecipient.uid)
        .collection('messages')
        .doc(currentUser.uid)
        .collection('messages')
        .add({
      'message': message,
      'senderId': currentUser.uid,
      'recipientId': selectedChatRecipient.uid,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  static Future<void> updateUnreadMessageCount(
      String workerUID, String companyUID, int i) async {
    await firestore
        .collection('ChatLists')
        .doc(workerUID)
        .collection('WorkerChatLists')
        .doc(companyUID)
        .update({'unreadMessageCount': i});
  }

  static Future<void> updateBothChatLists(AppUser? appUser,
      ChatRecipient? selectedChatRecipient, String userType) async {
    ChatRecipient chatRecipient = ChatRecipient.fromAppUser(appUser!);
    chatRecipient.clientType = userType;

    int previousUnreadMessageCount = await getPreviousUnreadMessageCount(
        appUser.uid, selectedChatRecipient!.uid);

    chatRecipient.unreadMessageCount = previousUnreadMessageCount + 1;

    firestore
        .collection('ChatLists')
        .doc(appUser.uid)
        .collection('CompanyChatLists')
        .doc(selectedChatRecipient.uid)
        .set(selectedChatRecipient.toMap());

    firestore
        .collection('ChatLists')
        .doc(selectedChatRecipient.uid)
        .collection('WorkerChatLists')
        .doc(appUser.uid)
        .set(chatRecipient.toMap());
  }

  static Stream<List<ChatRecipient>> getWorkerChatRecipientsStream(String uid) {
    return firestore
        .collection('ChatLists')
        .doc(uid)
        .collection('WorkerChatLists')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => ChatRecipient.fromMap(doc.data()))
            .toList());
  }

  static Future<int> getPreviousUnreadMessageCount(
      String companyUID, String workerUID) async {
    try {
      // Access the Firestore collection
      var documentSnapshot = await firestore
          .collection('ChatLists')
          .doc(workerUID)
          .collection('WorkerChatLists')
          .doc(companyUID)
          .get();

      // Check if the document exists
      if (documentSnapshot.exists) {
        // Retrieve the unreadMessageCount parameter
        var data = documentSnapshot.data();
        return data?['unreadMessageCount'] ?? 0;
      } else {
        // Document does not exist
        return 0;
      }
    } catch (e) {
      // Handle any errors
      print('Error getting unread message count: $e');
      return 0;
    }
  }

  static Stream<int> getUnreadMessageCountStream(String workerUID) async* {
    await for (var querySnapshot in firestore
        .collection('ChatLists')
        .doc(workerUID)
        .collection('WorkerChatLists')
        .snapshots()) {
      int totalUnreadMessages = 0;

      // Iterate over all documents in the snapshot
      for (var doc in querySnapshot.docs) {
        var data = doc.data();
        int unreadMessageCount = data['unreadMessageCount'] ?? 0;
        totalUnreadMessages += unreadMessageCount;
      }

      // Yield the total unread messages count
      yield totalUnreadMessages;
    }
  }

  static Stream<int> getUnreadMessageCountStreamCompany(
      String workerUID) async* {
    await for (var querySnapshot in firestore
        .collection('ChatLists')
        .doc(workerUID)
        .collection('CompanyChatLists')
        .snapshots()) {
      int totalUnreadMessages = 0;

      // Iterate over all documents in the snapshot
      for (var doc in querySnapshot.docs) {
        var data = doc.data();
        int unreadMessageCount = data['unreadMessageCount'] ?? 0;
        totalUnreadMessages += unreadMessageCount;
      }

      // Yield the total unread messages count
      yield totalUnreadMessages;
    }
  }

  static Future<void> updateBothChatListsWorker(
      AppUser? appUser, ChatRecipient? selectedChatRecipient) async {
    ChatRecipient chatRecipient = ChatRecipient.fromAppUserWorker(appUser!);
    chatRecipient.clientType = "Worker";

    int previousUnreadMessageCount = await getPreviousUnreadMessageCount4Worker(
        appUser.uid, selectedChatRecipient!.uid);

    chatRecipient.unreadMessageCount = previousUnreadMessageCount + 1;

    firestore
        .collection('ChatLists')
        .doc(appUser.uid)
        .collection('WorkerChatLists')
        .doc(selectedChatRecipient!.uid)
        .set(selectedChatRecipient.toMap());

    firestore
        .collection('ChatLists')
        .doc(selectedChatRecipient.uid)
        .collection('CompanyChatLists')
        .doc(appUser.uid)
        .set(chatRecipient.toMap());
  }

  static Future<int> getPreviousUnreadMessageCount4Worker(
      String companyUID, String workerUID) async {
    try {
      // Access the Firestore collection
      var documentSnapshot = await firestore
          .collection('ChatLists')
          .doc(workerUID)
          .collection('CompanyChatLists')
          .doc(companyUID)
          .get();

      // Check if the document exists
      if (documentSnapshot.exists) {
        // Retrieve the unreadMessageCount parameter
        var data = documentSnapshot.data();
        return data?['unreadMessageCount'] ?? 0;
      } else {
        // Document does not exist
        return 0;
      }
    } catch (e) {
      // Handle any errors
      print('Error getting unread message count: $e');
      return 0;
    }
  }

  static Future<void> updateUnreadMessageCountCompany(
      String workerUID, String companyUID, int i) async {
    await firestore
        .collection('ChatLists')
        .doc(workerUID)
        .collection('CompanyChatLists')
        .doc(companyUID)
        .update({'unreadMessageCount': i});
  }
}
