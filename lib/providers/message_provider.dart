import 'package:flutter/material.dart';

import '../models/messages.dart';




class MessageProvider with ChangeNotifier {
  final List<Message> _messages = [
    Message(sender: 'Alice', content: 'Hello!', timestamp: DateTime.now().subtract(const Duration(minutes: 1)), replyTo: null, subject: '', receiver: '', attachments: []),
    Message(sender: 'Bob', content: 'How are you?', timestamp: DateTime.now().subtract(const Duration(minutes: 2)), replyTo: null, subject: '', receiver: '', attachments: []),
  ];

  List<Message> get messages => _messages;

  void addMessage(Message message) {
    _messages.add(message);
    notifyListeners();
  }


}


