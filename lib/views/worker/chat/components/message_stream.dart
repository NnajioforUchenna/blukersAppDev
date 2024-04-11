


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../providers/user_provider_parts/user_provider.dart';
import 'message_bubble.dart';

final _firestore = FirebaseFirestore.instance;

class MessagesStream extends StatelessWidget {

 // final String generateChatId;

  const MessagesStream({
    super.key,

   String? currentUserId, required receiverUserName,
  });

  @override
  Widget build(BuildContext context) {
    String? currentUserId = Provider.of<UserProvider>(context, listen: false).appUser?.uid;
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('single_messages')
          .doc()
          .collection('messages')
          .orderBy('createdAt')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container();
        } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(
            child: Text(
              'No messages available',
              style: TextStyle(fontSize: 14.sp),
            ),
          );
        }

        final messages = snapshot.data!.docs;
        List<Widget> messageWidgets = [];

        for (var message in messages) {
          final data = message.data() as Map<String, dynamic>;
          final messageText = data['text'] as String? ?? '';
          final isMe = currentUserId == data['senderId'];

          final messageWidget = MessageBubble(
            key: ValueKey(message.id),
            text: messageText,
            isMe: isMe,
            receiverUserName: 'receiverUserName',
          );

          messageWidgets.add(messageWidget);
        }

        return ListView(
          reverse: true,
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
          children: messageWidgets.reversed.toList(),
        );
      },
    );
  }
}