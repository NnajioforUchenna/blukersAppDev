// ignore_for_file: library_private_types_in_public_api

import 'package:blukers/views/common_vieiws/index.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../providers/user_provider_parts/user_provider.dart';
import 'components/message_stream.dart';

final _firestore = FirebaseFirestore.instance;

class MessageScreen extends StatefulWidget {
  static const String id = 'message_screen';
  // final String generateChatId;

  const MessageScreen({
    super.key,
    // required this.generateChatId,
  });

  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final messageTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  late String messageText;
  // late String generateChatId;

  // @override
  // void initState() {
  //   super.initState();
  //   generateChatId = widget.generateChatId;
  // }



  void sendMessage() {
    String messageText = messageTextController.text.trim();
    if (messageText.isNotEmpty) {
      String? currentUserId = Provider.of<UserProvider>(context, listen: false).appUser?.uid;
      _firestore
          .collection('chat')
          .doc(currentUserId)
          .collection('chat-receipts')
          .add({
        'text': messageText,
        'type': 'text',
        'senderId': currentUserId,
        'receiverId': '',
        'createdAt': FieldValue.serverTimestamp(),
      });
      messageTextController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    String? currentUserId = Provider.of<UserProvider>(context, listen: false).appUser?.uid;
    return Scaffold(
      appBar: const MyAppBar(title: 'Username',),
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: MessagesStream(
                  currentUserId: currentUserId,
                  receiverUserName: '',
                  // generateChatId: generateChatId,
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Colors.blue,width: 2),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: messageTextController,
                        onChanged: (value) {
                          messageText = value;
                        },
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                          hintText: 'Message...',
                          hintStyle: TextStyle(fontSize: 14),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: sendMessage,
                      icon: const Icon(
                        Icons.send,
                        color: Colors.blue,
                        size: 25,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}




