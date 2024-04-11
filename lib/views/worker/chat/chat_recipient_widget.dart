import 'package:blukers/models/chat_recipient.dart';
import 'package:flutter/material.dart';

class ChatRecipientWidget extends StatelessWidget {
  final ChatRecipient? chatRecipient;
  const ChatRecipientWidget({super.key, this.chatRecipient});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: GestureDetector(
        onTap: (){
          // Todo: The chat interface will be triggered here
          // Todo: The recipient user ID will be collected
        },
        child: Material(
          borderRadius: BorderRadius.circular(10),
          elevation: 3,
          child: ListTile(
              leading: CircleAvatar(backgroundImage: AssetImage('assets/images/companyLogoPage.png')),
            title: Text('Display name'),
            subtitle: Text('Client type'),
          ),
        ),
      ),
    );
  }
}
