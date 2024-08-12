import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../providers/worker_chat_provider.dart';

class WorkerProfileDialogue extends StatelessWidget {
  const WorkerProfileDialogue({super.key});

  @override
  Widget build(BuildContext context) {
    WorkerChatProvider wcp = Provider.of<WorkerChatProvider>(context);

    return AlertDialog(
      title: const Text('Profile'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(wcp.selectedChatRecipient!.photoUrl),
          ),
          const SizedBox(height: 10),
          Text(wcp.selectedChatRecipient!.displayName, style: const TextStyle(fontWeight: FontWeight.bold),),
          const SizedBox(height: 10),
          Text(wcp.selectedChatRecipient!.email),
          const SizedBox(height: 10),
          Text(wcp.selectedChatRecipient!.clientType),

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
