import 'package:bulkers/models/chat_message.dart';
import 'package:bulkers/providers/chat_provider.dart';
import 'package:bulkers/services/notification_service.dart';
import 'package:bulkers/utils/styles/index.dart';
import 'package:bulkers/views/company/workers_components/chat_component.dart';
import 'package:bulkers/views/common_views/components/index.dart';
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
    onSendMessage() async {
      // print(messagesLength);
      _textController.clear();
      _scrollController.animateTo(0,
          duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
      await chatProvider.sendMessage(textMessage, up.appUser!.uid, roomId);
      setState(() {
        textMessage = "";
      });
    }

    return WillPopScope(
      onWillPop: () async {
        print("back");
        chatProvider.activeRoomId = "";
        return true;
      },
      child: Scaffold(
        appBar: MyAppBar(
          title: roomName,
        ),
        backgroundColor: ThemeColors.chatScreenBackgroundColor,
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
                              bool isMe =
                                  (chatMessage.sentBy == up.appUser!.uid);
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
                      },
                      child: Container(
                        margin: const EdgeInsets.only(left: 8),
                        child: Icon(
                          Icons.send_rounded,
                          size: 27,
                          color:
                              (textMessage != "") ? Colors.white : Colors.grey,
                        ),
                      ))
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
