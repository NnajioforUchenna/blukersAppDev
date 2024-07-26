import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/chat_provider.dart';
import '../../../../providers/user_provider_parts/user_provider.dart';
import '../../../common_vieiws/policy_terms/policy_terms_components/my_app_bar.dart';
import '../components/message_stream.dart';

class WorkerChatRoomWeb extends StatelessWidget {
  WorkerChatRoomWeb({super.key});

  final messageTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String? currentUserId =
        Provider.of<UserProvider>(context, listen: false).appUser?.uid;
    ChatProvider cp = Provider.of<ChatProvider>(context);
    return Scaffold(
      appBar: MyAppBar(
        title: cp.selectedChatRecipient?.displayName ?? 'Not Given',
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: MessagesStream(
              currentUserId: currentUserId,
              receiverUserName: '',
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.blue, width: 2),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: messageTextController,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      hintText: 'Message...',
                      hintStyle: TextStyle(fontSize: 14),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    if (messageTextController.text.trim().isNotEmpty) {
                      cp.sendChat(messageTextController.text.trim());
                      messageTextController.clear();
                    }
                  },
                  icon: const Icon(
                    Icons.send,
                    color: Colors.blue,
                    size: 25,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}