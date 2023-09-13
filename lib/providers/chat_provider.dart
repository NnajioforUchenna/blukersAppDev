import 'package:blukers/data_providers/chat_data_provider.dart';
import 'package:blukers/models/app_user.dart';
import 'package:blukers/models/chat_message.dart';
import 'package:blukers/models/chat_room.dart';
import 'package:blukers/models/worker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ChatProvider with ChangeNotifier {
  final List<ChatRoom> _chatRooms = [];
  String activeRoomId = "";

  List<ChatRoom> get chatRooms => _chatRooms;

  Future<String?> createChatRoom(
      {required String myUid,
      required String recipientUid,
      required String myName,
      required String recipientName,
      required String message,
      String myLogo = "",
      String recipientLogo = ""}) async {
    EasyLoading.show(
      status: '',
      maskType: EasyLoadingMaskType.black,
    );
    int chat = _chatRooms.indexWhere((element) =>
        element.members[0] == myUid && element.members[1] == recipientUid);
    ChatRoom chatRoom;
    //if chat room does not exist then create chat room
    //else move user to already created chatroom
    print("chat" + chat.toString());
    if (chat == -1) {
      chatRoom = await ChatDataProvider.createChatRoom(
          myUid: myUid,
          recipientUid: recipientUid,
          myName: myName,
          recipientName: recipientName,
          message: message,
          myLogo: myLogo,
          recipientLogo: recipientLogo);
      _chatRooms.add(chatRoom);
      notifyListeners();
    } else {
      chatRoom = _chatRooms[chat];
    }
    EasyLoading.dismiss();
    return chatRoom.id;
  }

  getGroups(String uid) async {
    EasyLoading.show(
      status: '',
      maskType: EasyLoadingMaskType.black,
    );
    final List<Map<String, dynamic>> res =
        await ChatDataProvider.fetchGroupsByUserId(uid);
    for (int i = 0; i < res.length; ++i) {
      _chatRooms.add(ChatRoom.fromMap(res[i]));
    }
    EasyLoading.dismiss();
    // notifyListeners();// This is create an endless loop
  }

  void notifyListners() {
    notifyListeners();
  }

  void clearGroups() {
    _chatRooms.clear();
    activeRoomId = "";
  }

  sendMessage(String message, String sentById, String roomId, String sentToId,
      String sentByName) async {
    ChatMessage chatMessage = ChatMessage(
        message: message,
        sentAt: DateTime.now(),
        sentBy: sentById,
        roomId: roomId);

    await ChatDataProvider.sendMessage(
        chatMessage: chatMessage,
        roomId: roomId,
        sentToId: sentToId,
        sentByName: sentByName);
    await ChatDataProvider.updateLastMEssage(message, roomId);
    int index = _chatRooms.indexWhere((element) => element.id == roomId);

    _chatRooms[index].lastMessage = message;

    notifyListners();
  }

  Stream<QuerySnapshot> getMessagesByGroupId(String groupId) {
    return ChatDataProvider.fetchMessagesByGroupId(groupId);
  }

  Map<String, String> chatDetails = {
    "roomId": "<Room ID>",
    "sentToId": "<Sent To ID>",
    "roomName": "<Room Name>",
  };
  Future<void> startRoom(AppUser? appUser, Worker worker) async {
    String? roomId = await createChatRoom(
        myUid: appUser!.uid,
        recipientUid: worker.workerId,
        myName: appUser!.displayName ?? "Company",
        recipientName: worker.firstName + worker.lastName,
        message: "",
        myLogo: appUser!.photoUrl ?? "",
        recipientLogo: worker.profilePhotoUrl ?? "");

    chatDetails["roomId"] = roomId ?? "";
    chatDetails["sentToId"] = worker.workerId;
    chatDetails["roomName"] = worker.firstName + worker.lastName;
    notifyListeners();
  }
}
