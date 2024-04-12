import 'package:blukers/models/chat_recipient.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../providers/chat_provider.dart';

class ChatRecipientWidget extends StatelessWidget {
  final ChatRecipient? chatRecipient;
  const ChatRecipientWidget({super.key, this.chatRecipient});

  @override
  Widget build(BuildContext context) {
    ChatProvider cp = Provider.of<ChatProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: GestureDetector(
        onTap: () {
          cp.setChatRecipient(chatRecipient);
          context.push('/messageScreen');
        },
        child: Material(
          borderRadius: BorderRadius.circular(10),
          elevation: 3,
          child: ListTile(
            leading: const CircleAvatar(
                backgroundImage:
                    AssetImage('assets/images/companyLogoPage.png')),
            title: Text(chatRecipient?.displayName ?? 'Not Given'),
            subtitle: Text(chatRecipient?.clientType ?? 'Not Given'),
          ),
        ),
      ),
    );
  }
}
