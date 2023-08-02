import 'package:bulkers/providers/chat_provider.dart';
import 'package:bulkers/providers/user_provider.dart';
import 'package:bulkers/utils/styles/index.dart';
import 'package:bulkers/views/company/workers_components/chat_list_component.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../common_views/page_template/page_template.dart';

class CompanyChat extends StatelessWidget {
  const CompanyChat({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider up = Provider.of<UserProvider>(context);
    ChatProvider chatProvider = Provider.of<ChatProvider>(context);
    return PageTemplate(
      child: Container(
        child: chatProvider.chatRooms.isEmpty
            ? const Center(
                child: Text(
                  "No Chats Available!",
                  style: ThemeTextStyles.headingThemeTextStyle,
                ),
              )
            : ListView.builder(
                itemCount: chatProvider.chatRooms.length,
                itemBuilder: (BuildContext context, int index) {
                  return ChatListComponent(
                    chatRoom: chatProvider.chatRooms[index],
                    onTap: () {
                      print("tap");
                      // chatProvider.getMessagesByGroupId(
                      //     chatProvider.chatRooms[index].id);
                      Navigator.pushNamed(context, '/chat-message', arguments: {
                        "roomId": chatProvider.chatRooms[index].id,
                        "roomName": chatProvider.chatRooms[index].roomName,
                      });
                      // chatProvider.createChatRoom(
                      //     myUid: "iQ9M1ieRt9P4Er7W5G5KSzNNrB43",
                      //     recipientUid: "tneFz8KUXnPVD4Rx9mIVhQlqHbI2",
                      //     roomName: "Test Room 3",
                      //     message: "test message 3");
                    },
                  );
                }),
      ),
    );
  }
}
