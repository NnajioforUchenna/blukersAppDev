import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/messages.dart';
import '../../../providers/message_provider.dart';
import 'company_message_dialog.dart';

class DesktopCompanyMessages extends StatefulWidget {
  const DesktopCompanyMessages({super.key});

  @override
  _DesktopCompanyMessagesState createState() => _DesktopCompanyMessagesState();
}

class _DesktopCompanyMessagesState extends State<DesktopCompanyMessages> {
  Message? _selectedMessage;

  void _selectMessage(Message message) {
    setState(() {
      _selectedMessage = message;
    });
  }

  void _composeMessage() {
    showDialog(
      context: context,
      builder: (context) => ComposeMessageDialog(
        onSend: (message) {
          Provider.of<MessageProvider>(context, listen: false).addMessage(message);
          Navigator.of(context).pop();
        },
        // isReply: false,
      ),
    );
  }

  void _replyMessage() {
    if (_selectedMessage == null) return;

    showDialog(
      context: context,
      builder: (context) => ReplyMessageDialog(
        onSend: (message) {
          Provider.of<MessageProvider>(context, listen: false).addMessage(message);
          Navigator.of(context).pop();
        },
        // isReply: true,
        replyTo: _selectedMessage!,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inbox'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _composeMessage,
            tooltip: 'Compose Message',
          ),
          if (_selectedMessage != null)
            IconButton(
              icon: const Icon(Icons.reply),
              onPressed: _replyMessage,
              tooltip: 'Reply to Message',
            ),
        ],
      ),
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: MessageList(onMessageSelected: _selectMessage),
          ),
          const VerticalDivider(thickness: 1, width: 1),
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
      return const Center(child: Text('Select a message'));
    }
    return Padding(
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
    );
  }
}


