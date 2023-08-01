import 'package:bulkers/models/chat_message.dart';
import 'package:bulkers/providers/chat_provider.dart';
import 'package:bulkers/views/company/workers_components/chat_component.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/user_provider.dart';

class ChatMessageScreen extends StatefulWidget {
  const ChatMessageScreen(Object? arguments, {super.key});

  @override
  State<ChatMessageScreen> createState() => _ChatMessageScreenState();
}

class _ChatMessageScreenState extends State<ChatMessageScreen> {
  String textMessage = "";
  int messagesLength = 0;
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String roomId = (ModalRoute.of(context)!.settings.arguments
        as Map<String, String>)["roomId"] as String;
    String roomName = (ModalRoute.of(context)!.settings.arguments
        as Map<String, String>)["roomName"] as String;
    UserProvider up = Provider.of<UserProvider>(context);
    ChatProvider chatProvider = Provider.of<ChatProvider>(context);
    onSendMessage() {
      // print(messagesLength);
      _textController.clear();
      _scrollController.animateTo(0,
          duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
      chatProvider.sendMessage(textMessage, up.appUser!.uid, roomId);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(roomName),
      ),
      backgroundColor: Colors.grey[400],
      body: SafeArea(
        child: Column(children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
                stream: chatProvider.getMessagesByGroupId(roomId),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    List<QueryDocumentSnapshot<Object?>>? messages =
                        snapshot.data?.docs.reversed.toList();

                    return Container(
                      //height: 500,
                      // width:250,
                      // margin: const EdgeInsets.symmetric(vertical: 12),
                      //color: Colors.amber,
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
                                message: chatMessage.message, isMe: isMe,time: chatMessage.sentAt,);
                          }),
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                }),
          ),
          Container(
            height: 70,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12))),
            // color: Colors.red,
            child: Row(
              children: [
                SizedBox(
                    width: MediaQuery.of(context).size.width * 3.5 / 4,
                    child: TextField(
                      controller: _textController,
                      onChanged: (value) {
                        textMessage = value;
                      },
                    )),
                GestureDetector(
                    onTap: () {
                      onSendMessage();
                    },
                    child: const Icon(
                      Icons.send_rounded,
                      size: 27,
                    ))
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
