import 'package:bulkers/data_providers/chat_data_provider.dart';
import 'package:bulkers/models/chat_message.dart';
import 'package:bulkers/models/chat_room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ChatProvider with ChangeNotifier {
  final List<ChatRoom> _chatRooms = [];

  List<ChatRoom> get chatRooms => _chatRooms;

  createChatRoom(
      {required String myUid,
      required String recipientUid,
      required String roomName,
      required String message}) async {
    EasyLoading.show(
      status: 'Setting up your chat',
      maskType: EasyLoadingMaskType.black,
    );
    await ChatDataProvider.createChatRoom(
        myUid: myUid,
        recipientUid: recipientUid,
        roomName: roomName,
        message: message);
    EasyLoading.dismiss();
  }

  getGroups(String uid) async {
    EasyLoading.show(
      status: 'Setting up your chat',
      maskType: EasyLoadingMaskType.black,
    );
    final List<Map<String, dynamic>> res =
        await ChatDataProvider.fetchGroupsByUserId(uid);
    for (int i = 0; i < res.length; ++i) {
      _chatRooms.add(ChatRoom.fromMap(res[i]));
    }
    EasyLoading.dismiss();
    notifyListeners();
  }

  sendMessage(String message, String sentBy, String roomId) async {
    ChatMessage chatMessage =
        ChatMessage(message: message, sentAt: DateTime.now(), sentBy: sentBy);
    int index = _chatRooms.indexWhere((element) => element.id == roomId);
    _chatRooms[index].lastMessage = message;

    await ChatDataProvider.sendMessage(chatMessage, roomId);
    await ChatDataProvider.updateLastMEssage(message, roomId);
    notifyListeners();
  }

  Stream<QuerySnapshot> getMessagesByGroupId(String groupId) {
    return ChatDataProvider.fetchMessagesByGroupId(groupId);
  }
}
