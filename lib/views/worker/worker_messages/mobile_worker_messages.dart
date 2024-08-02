import 'package:blukers/providers/message_provider.dart';
import 'package:blukers/views/worker/worker_messages/workers_message_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/messages.dart';


class MobileWorkerMessages extends StatelessWidget {
  const MobileWorkerMessages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('W - Inbox'),
        // Theme: ThemeData(
        //   primarySwatch: Colors.blue,
        // ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return const MessageList();
        },
      ),
    );
  }
}

class InboxScreen extends StatelessWidget {
  const InboxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inbox', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}

class MessageList extends StatelessWidget {
  const MessageList({super.key});

  @override
  Widget build(BuildContext context) {
    final messages = Provider.of<MessageProvider>(context).messages;
    return ListView.builder(
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final message = messages[index];
        return ListTile(
          title: Text(message.sender),
          subtitle: Text(message.content),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => MessageDetails(message: message)),
            );
          },
        );
      },
    );
  }
}

class MessageDetails extends StatelessWidget {
  final Message? message;

  const MessageDetails({super.key, this.message});

  void _replyMessage(BuildContext context) {
    if (message == null) return;

    showDialog(
      context: context,
      builder: (context) => ReplyMessageDialog(
        onSend: (reply) {
          Provider.of<MessageProvider>(context, listen: false).addMessage(reply);
          Navigator.of(context).pop();
        },
        // isReply: true,
        replyTo: message!,
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    if (message == null) {
      return const Center(child: Text('Select a message'));
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Message from ${message!.sender}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.reply),
            onPressed: () => _replyMessage(context),
            tooltip: 'Reply to Message',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('From: ${message!.sender}', style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text('Sent: ${message!.timestamp}', style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 20),
            Text(message!.content),
          ],
        ),
      ),
    );
  }
}
