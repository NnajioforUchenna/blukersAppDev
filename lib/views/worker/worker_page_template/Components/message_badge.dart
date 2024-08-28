import 'package:blukers/providers/worker_chat_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'MessageBadgeAnimation.dart';

class MessageBadge extends StatelessWidget {
  const MessageBadge({super.key});

  @override
  Widget build(BuildContext context) {
    WorkerChatProvider wp = Provider.of<WorkerChatProvider>(context);
    int messageCount = wp.unreadMessageCount;
    return MessageBadgeAnimation(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red,
                ),
                alignment: Alignment.center,
                child: Text(
                  messageCount.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
  }
}
