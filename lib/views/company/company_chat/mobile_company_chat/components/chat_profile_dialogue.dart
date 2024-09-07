import 'package:blukers/providers/user_provider_parts/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../providers/company_chat_provider.dart';

class ChatProfileWIndowDialogue extends StatelessWidget {
  const ChatProfileWIndowDialogue({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    CompanyChatProvider cp = Provider.of<CompanyChatProvider>(context);
    UserProvider up = Provider.of<UserProvider>(context);


    return AlertDialog(
      title: const Text('Profile'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(cp.selectedChatRecipient!.photoUrl),
          ),
          const SizedBox(height: 10),
          Text(cp.selectedChatRecipient!.displayName, style: const TextStyle(fontWeight: FontWeight.bold),),

          const SizedBox(height: 10),
          Text(cp.selectedChatRecipient!.email),
          const SizedBox(height: 10),
          Text(cp.selectedChatRecipient!.clientType),

        ],
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Close'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}