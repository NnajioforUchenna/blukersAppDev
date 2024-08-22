import 'package:blukers/providers/company_chat_provider.dart';
import 'package:blukers/providers/user_provider_parts/user_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../models/chat_message.dart';
import '../../../common_vieiws/loading_page.dart';
import '../../workers_home/workers_components/chat_component.dart';
import 'components/chat_profile_dialogue.dart';

class CompanyChatRoomScreen extends StatefulWidget {
  const CompanyChatRoomScreen({super.key});

  @override
  State<CompanyChatRoomScreen> createState() => _CompanyChatRoomScreenState();
}

class _CompanyChatRoomScreenState extends State<CompanyChatRoomScreen> {
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
      return const Text('Selected Chat Recipient appears to be null');
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(cp.selectedChatRecipient?.displayName ?? ""),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const ChatProfileWIndowDialogue();
                  });
            },
          ),

        ],

      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Color(0xFFFEF7FF),
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
      ),
    );
  }
}


