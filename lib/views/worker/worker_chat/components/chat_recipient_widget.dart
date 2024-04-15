import 'package:blukers/models/chat_recipient.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../providers/chat_provider.dart';

class ChatRecipientWidget extends StatelessWidget {
  final ChatRecipient? chatRecipient;
  const ChatRecipientWidget({Key? key, this.chatRecipient}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ChatProvider cp = Provider.of<ChatProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: GestureDetector(
        onTap: () {
          cp.setChatRecipient(chatRecipient!);
          context.push('/workerChatRoom');
        },
        child: Material(
          borderRadius: BorderRadius.circular(10),
          elevation: 3,
          child: ListTile(
            leading: const CircleAvatar(
              backgroundImage: AssetImage('assets/images/companyLogoPage.png'),
            ),
            title: Text(chatRecipient?.displayName ?? 'Not Given'),
            subtitle: Text(chatRecipient?.clientType ?? 'Not Given'),
            trailing: Visibility(
              visible: chatRecipient?.unreadMessageCount != 0,
              child: Container(
                width: 23,
                height: 23,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blueAccent,
                ),
                child: Center(
                  child: Text(
                    '${chatRecipient?.unreadMessageCount ?? 0}', // Use unreadMessageCount dynamically
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
