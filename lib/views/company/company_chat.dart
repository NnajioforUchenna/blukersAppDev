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
                      //     myUid: up.appUser!.uid,
                      //     recipientUid: "tt7wei2DIUfvcb294hXrOVtHf6p2",
                      //     roomName: up.appUser!.displayName ?? "My Room",
                      //     message: "test message 3",
                      //     chatLogo:
                      //         "https://firebasestorage.googleapis.com/v0/b/blukers-development.appspot.com/o/users%2Fdfe6f4bd20c02bd964b002b7bfbeeefe.jpeg?alt=media&token=f647bf7c-aad7-4ece-aaa3-affde0dd6196");
                    },
                  );
                }),
      ),
    );
  }
}
