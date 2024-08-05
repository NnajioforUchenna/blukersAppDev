import 'package:blukers/models/chat_message.dart';
import 'package:blukers/providers/company_chat_provider.dart';
import 'package:blukers/providers/user_provider_parts/user_provider.dart';
import 'package:blukers/views/company/workers_home/workers_components/chat_component.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../common_vieiws/loading_page.dart';
import '../../mobile_company_chat/components/chat_profile_dialogue.dart';


class WebCompanyChatRoomScreen extends StatefulWidget {
  const WebCompanyChatRoomScreen({super.key});

  @override
  State<WebCompanyChatRoomScreen> createState() => _WebCompanyChatRoomScreenState();
}

class _WebCompanyChatRoomScreenState extends State<WebCompanyChatRoomScreen> {
  String textMessage = "";
  int messagesLength = 0;
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    CompanyChatProvider cp = Provider.of<CompanyChatProvider>(context);
    UserProvider up = Provider.of<UserProvider>(context);

    // Send message function
    onSendMessage() async {
      _textController.clear();
      _scrollController.animateTo(0,
          duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
      await cp.sendMessage(textMessage);
    }

    if (cp.selectedChatRecipient == null) {
      return const Center(child: Text('Select a user to chat'));
    }

    return  Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.blueGrey,
              child: StreamBuilder<QuerySnapshot>(
                  stream: cp.getMessagesByRoomId(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      List<QueryDocumentSnapshot<Object?>>? messages =
                      snapshot.data?.docs.reversed.toList();
                      return ListView.builder(
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
                          });
                    } else {
                      return const LoadingPage();
                    }
                  }),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextField(
                      controller: _textController,
                      onChanged: (value) {
                        setState(() {
                          textMessage = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Type a message',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          // Adjust radius as needed
                        ),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.send_outlined,
                    color: (textMessage != "")
                        ? Colors.blueGrey[900]
                        : Colors.grey,
                  ),
                  onPressed: () {
                    if (textMessage == "") {
                      return;
                    }
                    onSendMessage();
                    setState(() {
                      textMessage = "";
                    });
                  },
                ),
              ],
            ),
          )
        ],
    );
  }
}


