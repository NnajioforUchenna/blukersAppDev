import 'package:blukers/providers/company_chat_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../models/chat_recipient.dart';

class CompanyChatRecipientWidget extends StatelessWidget {
  final ChatRecipient? chatRecipient;
  const CompanyChatRecipientWidget({super.key, this.chatRecipient});

  @override
  Widget build(BuildContext context) {
    CompanyChatProvider cp = Provider.of<CompanyChatProvider>(context);
    String photoUrl =
        chatRecipient?.photoUrl ?? 'assets/images/companyLogoPage.png';
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: GestureDetector(
        onTap: () {
          cp.setChatRecipient(chatRecipient!);
          context.push('/companyChatRoomScreen');
        },
        child: Material(
          borderRadius: BorderRadius.circular(10),
          elevation: 3,
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(photoUrl),
            ),
            title: Text(chatRecipient?.displayName ?? 'Not Given'),
            subtitle: Text(chatRecipient?.clientType ?? 'Not Given'),
            trailing: Visibility(
              visible: chatRecipient?.unreadMessageCount != 0,
              child: Container(
                width: 23,
                height: 23,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blueAccent,
                ),
                child: Center(
                  child: Text(
                    '${chatRecipient?.unreadMessageCount ?? 0}', // Use unreadMessageCount dynamically
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
