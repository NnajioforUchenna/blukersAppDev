import 'package:blukers/views/company/company_chat/mobile_company_chat/components/chat_message_bubble.dart';
import 'package:flutter/material.dart';

import '../../../../models/company_chat_models/message_model.dart';

class CompanyChatScreen extends StatefulWidget {
  const CompanyChatScreen({super.key});

  @override
  State<CompanyChatScreen> createState() => _CompanyChatScreenState();
}

class _CompanyChatScreenState extends State<CompanyChatScreen> {

  final List<CompanyChatMessageModel> messages = [
    CompanyChatMessageModel(
        messageId: 'messageId',
        senderId: 'senderId',
        recipientId: 'recipientId',
        messageBody: 'This is a dummy message body',
        timestamp: DateTime.now()
    ),
    CompanyChatMessageModel(
      messageId: 'messageId',
      senderId: 'senderId',
      recipientId: 'recipientId',
      messageBody: 'This is a dummy message body',
      timestamp: DateTime.now()
    ),
    CompanyChatMessageModel(
      messageId: 'messageId',
      senderId: 'senderId',
      recipientId: 'recipientId',
      messageBody: 'This is a dummy message body',
      timestamp: DateTime.now()
    )
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.blueGrey,
              child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages[index];
                  // Assume currentUserId is the ID of the logged-in user
                  const bool isMe = true;

                  return ChatMessageBubble(

                    isMe: isMe, message: message,
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                const Icon(Icons.person),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextField(
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
                const Icon(Icons.send_outlined),
              ],
            ),
          )
        ],
      ),
    );
  }
}
