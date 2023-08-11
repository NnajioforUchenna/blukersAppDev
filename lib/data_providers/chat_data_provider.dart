import 'package:bulkers/models/chat_message.dart';
import 'package:bulkers/models/chat_room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

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
    print("res:: "+res.toString());
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
}
