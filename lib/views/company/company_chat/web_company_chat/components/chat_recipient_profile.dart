import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../providers/company_chat_provider.dart';

class ChatRecipientProfile extends StatefulWidget {
  const ChatRecipientProfile({super.key});

  @override
  State<ChatRecipientProfile> createState() => _ChatRecipientProfileState();
}

class _ChatRecipientProfileState extends State<ChatRecipientProfile> {
  @override
  Widget build(BuildContext context) {
    CompanyChatProvider cp = Provider.of<CompanyChatProvider>(context);

    bool hasData = cp.selectedChatRecipient != null &&
        cp.selectedChatRecipient!.photoUrl != null &&
        cp.selectedChatRecipient!.displayName != null &&
        cp.selectedChatRecipient!.email != null &&
        cp.selectedChatRecipient!.clientType != null;

    if (hasData) {
      return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage:
          NetworkImage(cp.selectedChatRecipient!.photoUrl),
        ),
        const SizedBox(height: 10),
        Text(
          cp.selectedChatRecipient!.displayName,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Text(cp.selectedChatRecipient!.email),
        const SizedBox(height: 10),
        Text(cp.selectedChatRecipient!.clientType),
      ],
    );
    } else {
      return Center(child: const Text('Click on a user to view basic info'));
    }
  }
}
