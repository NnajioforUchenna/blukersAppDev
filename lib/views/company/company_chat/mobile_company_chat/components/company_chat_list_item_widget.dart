import 'package:blukers/models/company_chat_models/recipient_chat_list_model.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class ChatListItemWidget extends StatelessWidget {
  final ChatRecipientListModel chatListItem;

  const ChatListItemWidget({super.key, required this.chatListItem});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(chatListItem.photoUrl),
      ),
      title: Text(chatListItem.displayName),
      subtitle: Text(chatListItem.email),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Text(
              timeago.format(chatListItem.lastMessageTimestamp.toDate()),
              style: const TextStyle(fontSize: 12.0),
            ),
          ),
          const SizedBox(height: 4.0),
          if (chatListItem.unreadMessageCount > 0)
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Text(
                  '${chatListItem.unreadMessageCount}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white, fontSize: 10.0),
                ),
              ),
            ),
        ],
      ),
      onTap: () {
        // Handle chat item tap
      },
    );
  }
}
