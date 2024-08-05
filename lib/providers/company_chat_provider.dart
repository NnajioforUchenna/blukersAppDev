import 'package:blukers/models/chat_recipient.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../data_providers/chat_data_provider.dart';
import '../models/app_user/app_user.dart';
import '../models/chat_message.dart';
import '../models/chat_room.dart';
import '../models/worker.dart';

class CompanyChatProvider with ChangeNotifier {
  AppUser? appUser;

  List<ChatRecipient> chatRecipients = [];
  ChatRecipient? selectedChatRecipient;

  update(AppUser? user) {
    appUser = user;
    if (appUser != null) {
      notifyListeners();
    }
  }

  //______________________________________________________

  // Fetch chat recipients from Firestore

  Future<void> fetchChatRecipients() async {
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('chatRecipients').get();
      chatRecipients = snapshot.docs
          .map((doc) =>
              ChatRecipient.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
      notifyListeners();
    } catch (e) {
      print("Error fetching chat recipients: $e");
    }
  }

  Stream<List<ChatRecipient>> getChatRecipientsStream() {
    if (appUser == null) return const Stream.empty();
    return ChatDataProvider.getChatRecipientsStream(appUser!.uid);
  }

  void setChatRecipient(ChatRecipient chatRecipient) {
    selectedChatRecipient = chatRecipient;
    selectedChatRecipient!.unreadMessageCount = 0;
    // ChatDataProvider.updateUnreadMessageCount(
    //     appUser!.uid, selectedChatRecipient!.uid, 0);
    notifyListeners();
  }

  void sendChat(String message) {
    ChatDataProvider.sendChat(message, appUser!, selectedChatRecipient!);
  }

  // _______________________________________________________

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
    //if worker_chat room does not exist then create worker_chat room
    //else move user to already created chatroom
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
        myName: appUser.displayName ?? "Company",
        recipientName: worker.workerResumeDetails!.firstName! +
            worker.workerResumeDetails!.lastName!,
        message: "",
        myLogo: appUser.photoUrl ?? "",
        recipientLogo: worker.profilePhotoUrl ?? "");

    chatDetails["roomId"] = roomId ?? "";
    chatDetails["sentToId"] = worker.workerId;
    chatDetails["roomName"] = worker.workerResumeDetails!.firstName! +
        worker.workerResumeDetails!.lastName!;
    notifyListeners();
  }

  //________________________________________________________________________

  void companyStartChat(AppUser? appUser, Worker worker) {
    //update selectedChatRecipient
    selectedChatRecipient = ChatRecipient.fromWorker(worker);

    //1. Create a chat room
    //2. Add worker to the ChatRecipient list of Company
    //3. Add Company to the ChatRecipient list of Worker
  }

  String getRoomId() {
    String appUserId = appUser!.uid;
    String workerId = selectedChatRecipient!.uid;
    String roomId = appUserId.compareTo(workerId) > 0
        ? appUserId + workerId
        : workerId + appUserId;
    return roomId;
  }

  getMessagesByRoomId() {
    String roomId = getRoomId();
    return ChatDataProvider.fetchMessagesByGroupId(roomId);
  }

  sendMessage(String message) async {
    String sentById = appUser!.uid;
    String roomId = getRoomId();
    String sentToId = selectedChatRecipient!.uid;
    String sentByName = appUser!.getDisplayName ?? "Company";

    ChatMessage chatMessage = ChatMessage(
        message: message,
        sentAt: DateTime.now(),
        sentBy: sentById,
        roomId: roomId);

    ChatDataProvider.sendMessage(
        chatMessage: chatMessage,
        roomId: roomId,
        sentToId: sentToId,
        sentByName: sentByName);

    ChatDataProvider.updateBothChatLists(appUser, selectedChatRecipient);

    await ChatDataProvider.updateLastMEssage(message, roomId);

    int index = _chatRooms.indexWhere((element) => element.id == roomId);

    _chatRooms[index].lastMessage = message;

    notifyListners();
  }
}
