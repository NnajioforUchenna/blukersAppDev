import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../models/chat_message.dart';
import '../../../../providers/user_provider_parts/user_provider.dart';
import '../../../../providers/worker_chat_provider.dart';
import '../../../../utils/styles/theme_colors.dart';
import '../../../common_vieiws/loading_page.dart';
import '../../../company/workers_home/workers_components/chat_component.dart';

class WorkerChatRoom extends StatefulWidget {
  const WorkerChatRoom({super.key});

  @override
  State<WorkerChatRoom> createState() => _WorkerChatRoomState();
}

class _WorkerChatRoomState extends State<WorkerChatRoom> {
  String textMessage = "";
  int messagesLength = 0;
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    WorkerChatProvider wcp = Provider.of<WorkerChatProvider>(context);
    UserProvider up = Provider.of<UserProvider>(context);

    // Send message function
    onSendMessage() async {
      // print(messagesLength);
      _textController.clear();
      _scrollController.animateTo(0,
          duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
      await wcp.sendMessage(textMessage);
    }

    if (wcp.selectedChatRecipient == null) {
      return const LoadingPage();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(wcp.selectedChatRecipient?.displayName ?? ""),
      ),
      backgroundColor: ThemeColors.chatScreenBackgroundColor,
      body: SafeArea(
        child: Column(children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
                stream: wcp.getMessagesByRoomId(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    List<QueryDocumentSnapshot<Object?>>? messages =
                        snapshot.data?.docs.reversed.toList();
                    return Container(
                      //  color: Colors.white,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(52),
                            bottomRight: Radius.circular(52),
                          )),
                      child: ListView.builder(
                          reverse: true,
                          controller: _scrollController,
                          padding: const EdgeInsets.all(10),
                          itemCount: snapshot.data?.docs.length,
                          // reverse: true,
                          // controller: scrollController,
                          itemBuilder: (context, index) {
                            ChatMessage chatMessage = ChatMessage.fromMap(
                                messages![index].data()
                                    as Map<String, dynamic>);
                            bool isMe = (chatMessage.sentBy == up.appUser!.uid);
                            return ChatComponent(
                              message: chatMessage.message,
                              isMe: isMe,
                              time: chatMessage.sentAt,
                            );
                          }),
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                }),
          ),
          Container(
            height: 55,
            width: MediaQuery.of(context).size.width * 5 / 6,
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.only(top: 12, bottom: 12),
            decoration: const BoxDecoration(
                color: ThemeColors.chatScreenTextEditColor,
                borderRadius: BorderRadius.all(Radius.circular(40))),
            // color: Colors.red,
            child: Row(
              children: [
                Expanded(
                    child: TextField(
                  controller: _textController,
                  onChanged: (value) {
                    setState(() {
                      textMessage = value;
                    });
                  },
                  style: const TextStyle(color: Colors.white),
                )),
                GestureDetector(
                    onTap: () {
                      if (textMessage == "") {
                        return;
                      }
                      onSendMessage();
                      setState(() {
                        textMessage = "";
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(left: 8),
                      child: Icon(
                        Icons.send_rounded,
                        size: 27,
                        color: (textMessage != "") ? Colors.white : Colors.grey,
                      ),
                    ))
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
