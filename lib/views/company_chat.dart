import 'package:bulkers/providers/chat_provider.dart';
import 'package:bulkers/providers/user_provider.dart';
import 'package:bulkers/utils/styles/index.dart';
import 'package:bulkers/views/common_views/page_template/page_template.dart';
import 'package:bulkers/views/common_views/components/icon_text_404.dart';
import 'package:bulkers/views/company/workers_components/chat_list_component.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';

class CompanyChat extends StatelessWidget {
  const CompanyChat({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider up = Provider.of<UserProvider>(context);
    ChatProvider chatProvider = Provider.of<ChatProvider>(context);
    return PageTemplate(
      child: Container(
        child: chatProvider.chatRooms.isEmpty
            ? IconText404(text: "You have no chats", icon: UniconsLine.chat)
            : ListView.builder(
                itemCount: chatProvider.chatRooms.length,
                itemBuilder: (BuildContext context, int index) {
                  return ChatListComponent(
                    chatRoom: chatProvider.chatRooms[index],
                    onTap: () {
                      print("tap");
                      chatProvider.activeRoomId =
                          chatProvider.chatRooms[index].id;
                      List<String> sentToId = chatProvider
                          .chatRooms[index].members
                          .where((element) => element != up.appUser!.uid)
                          .toList();
                      Navigator.pushNamed(context, '/chat-message', arguments: {
                        "roomId": chatProvider.chatRooms[index].id,
                        "roomName": up.appUser!.uid ==
                                chatProvider.chatRooms[index].members[0]
                            ? chatProvider.chatRooms[index].names[1]
                            : chatProvider.chatRooms[index].names[0],
                          "sentToId": sentToId[0],
                      });
                    },
                  );
                }),
      ),
    );
  }
}