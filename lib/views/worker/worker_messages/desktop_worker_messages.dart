import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/message_provider.dart';

class DesktopWorkerMessages extends StatefulWidget {
  const DesktopWorkerMessages({super.key});

  @override
  _DesktopWorkerMessagesState createState() => _DesktopWorkerMessagesState();
}

class _DesktopWorkerMessagesState extends State<DesktopWorkerMessages> {
  Message? _selectedMessage;

  void _selectMessage(Message message) {
    setState(() {
      _selectedMessage = message;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inbox'),
      ),
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: MessageList(onMessageSelected: _selectMessage),
          ),
          VerticalDivider(thickness: 1, width: 1),
          Expanded(
            flex: 3,
            child: MessageDetails(message: _selectedMessage),
          ),
        ],
      ),
    );
  }
}

class MessageList extends StatelessWidget {
  final void Function(Message) onMessageSelected;

  const MessageList({required this.onMessageSelected, super.key});

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
          onTap: () => onMessageSelected(message),
        );
      },
    );
  }
}

class MessageDetails extends StatelessWidget {
  final Message? message;

  const MessageDetails({this.message, super.key});

  @override
  Widget build(BuildContext context) {
    if (message == null) {
      return Center(child: Text('Select a message'));
    }
    return Padding(
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
    );
  }
}


