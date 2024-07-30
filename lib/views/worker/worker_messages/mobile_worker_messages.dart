import 'package:blukers/providers/message_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MobileWorkerMessages extends StatelessWidget {
  const MobileWorkerMessages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inbox'),
        // Theme: ThemeData(
        //   primarySwatch: Colors.blue,
        // ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return MessageList();
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
        title: Text('Inbox', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}

class MessageList extends StatelessWidget {
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

  @override
  Widget build(BuildContext context) {
    if (message == null) {
      return Center(child: Text('Select a message'));
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Message from ${message!.sender}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('From: ${message!.sender}', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('Sent: ${message!.timestamp}', style: TextStyle(color: Colors.grey)),
            SizedBox(height: 20),
            Text(message!.content),
          ],
        ),
      ),
    );
  }
}
