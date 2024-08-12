import 'package:flutter/cupertino.dart';

import '../data_providers/chat_data_provider.dart';
import '../models/app_user/app_user.dart';
import '../models/chat_message.dart';
import '../models/chat_recipient.dart';

class WorkerChatProvider with ChangeNotifier {
  AppUser? appUser;

  List<ChatRecipient> chatRecipients = [];
  ChatRecipient? selectedChatRecipient;

  int unreadMessageCount = 0;

  WorkerChatProvider() {
    if (appUser != null) {
      startListeningToUnreadMessage(appUser!.uid);
    }
  }

  update(AppUser? user) {
    appUser = user;
    if (appUser != null) {
      startListeningToUnreadMessage(appUser!.uid);
      notifyListeners();
    }
  }

  Stream<List<ChatRecipient>> getChatRecipientsStream() {
    if (appUser == null) return const Stream.empty();
    return ChatDataProvider.getWorkerChatRecipientsStream(appUser!.uid);
  }

  String getRoomId() {
    String appUserId = appUser!.uid;
    String workerId = selectedChatRecipient!.uid;
    String roomId = appUserId.compareTo(workerId) > 0
        ? appUserId + workerId
        : workerId + appUserId;
    return roomId;
  }

  sendMessage(String message) {
    String sentById = appUser!.uid;
    String roomId = getRoomId();
    String sentToId = selectedChatRecipient!.uid;
    String sentByName = appUser!.getDisplayName;

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

    ChatDataProvider.updateBothChatListsWorker(appUser, selectedChatRecipient);

    notifyListeners();
  }

  void setChatRecipient(ChatRecipient chatRecipient) {
    selectedChatRecipient = chatRecipient;
    selectedChatRecipient!.unreadMessageCount = 0;
    ChatDataProvider.updateUnreadMessageCount(
        appUser!.uid, selectedChatRecipient!.uid, 0);
    notifyListeners();
  }

  getMessagesByRoomId() {
    String roomId = getRoomId();
    updateReadStatus();
    return ChatDataProvider.fetchMessagesByGroupId(roomId);
  }

  void startListeningToUnreadMessage(String uid) {
    ChatDataProvider.getUnreadMessageCountStream(uid).listen((event) {
      unreadMessageCount = event;
      notifyListeners();
    });
  }

  Future<void> updateReadStatus() async {
    selectedChatRecipient!.unreadMessageCount = 0;
    await ChatDataProvider.updateUnreadMessageCount(
        appUser!.uid, selectedChatRecipient!.uid, 0);
  }
}
