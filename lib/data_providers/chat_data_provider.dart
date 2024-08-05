import 'package:blukers/data_providers/push_notification.dart';
import 'package:blukers/models/chat_recipient.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

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

    var res = await http.post(
        Uri.parse(
            "https://sendmessagepushnotifications-v2xxr3wlvq-uc.a.run.app"),
        headers: {
          // "Accept": "application/json",
          "Access-Control-Allow-Origin": "*"
        },
        body: {
          "sentToId": sentToId,
          "roomId": roomId,
          "sentByName": sentByName,
          "message": chatMessage.message
        });
    print("res:: $res");
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

  static void updateUnreadMessageCount(String uid, String uid2, int i) {
    firestore
        .collection('chat')
        .doc(uid)
        .collection('chat-recipients')
        .doc(uid2)
        .update({'unreadMessageCount': i});
  }

  static void updateBothChatLists(
      AppUser? appUser, ChatRecipient? selectedChatRecipient) {
    ChatRecipient chatRecipient = ChatRecipient.fromAppUser(appUser!);

    firestore
        .collection('ChatLists')
        .doc(appUser.uid)
        .collection('CompanyChatLists')
        .doc(selectedChatRecipient!.uid)
        .set(selectedChatRecipient.toMap());

    firestore
        .collection('ChatLists')
        .doc(selectedChatRecipient.uid)
        .collection('WorkerChatLists')
        .doc(appUser.uid)
        .set(chatRecipient.toMap());
  }

  static Stream<List<ChatRecipient>> getWorkerChatRecipientsStream(String uid ) {
    return firestore
        .collection('ChatLists')
        .doc(uid)
        .collection('WorkerChatLists')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => ChatRecipient.fromMap(doc.data()))
            .toList());
  }
}
