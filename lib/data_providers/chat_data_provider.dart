import 'package:blukers/models/chat_recipient.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

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
      print("Error adding chat room to Firestore: $error");
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
    // for (int i = 0; i < snapshot.docs.length; i++) {
    //   //print(snapshot.docs[i].data());
    //   res.add(snapshot.docs[i].data());
    // }
    // return res;
  }

  // Async function to get chat recipients
  static Future<List<ChatRecipient>> getChatRecipients(String uid) async {
    try {
      // Access the specific document and subcollection
      QuerySnapshot snapshot = await firestore
          .collection('Chats')
          .doc(uid)
          .collection('ChatRecipients')
          .get();

      // Map each document to a ChatRecipient object
      List<ChatRecipient> recipients = snapshot.docs.map((doc) {
        return ChatRecipient.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();

      return recipients;
    } catch (e) {
      print(e.toString());
      // Handle exceptions or return an empty list
      return [];
    }
  }
}
