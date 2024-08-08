import 'package:blukers/models/chat_recipient.dart';
import 'package:blukers/providers/worker_chat_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WebChatWorkerRecipient extends StatelessWidget {
  final ChatRecipient? chatRecipient;

  const WebChatWorkerRecipient({super.key, this.chatRecipient});

  @override
  Widget build(BuildContext context) {
    WorkerChatProvider wcp = Provider.of<WorkerChatProvider>(context);

    bool hasData = wcp.selectedChatRecipient != null &&
        wcp.selectedChatRecipient!.photoUrl != null &&
        wcp.selectedChatRecipient!.displayName != null &&
        wcp.selectedChatRecipient!.email != null &&
        wcp.selectedChatRecipient!.clientType != null;

    if (hasData) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage:
            NetworkImage(wcp.selectedChatRecipient!.photoUrl),
          ),
          const SizedBox(height: 10),
          Text(
            wcp.selectedChatRecipient!.displayName,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(wcp.selectedChatRecipient!.email),
          const SizedBox(height: 10),
          Text(wcp.selectedChatRecipient!.clientType),
        ],
      );
    } else {
      return Center(child: const Text('Click on a user to view basic info'));
    }
  }
}
