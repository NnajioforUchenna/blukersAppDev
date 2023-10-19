import 'package:blukers/providers/chat_provider.dart';
import 'package:blukers/providers/user_provider_parts/user_provider.dart';
import 'package:blukers/views/common_views/components/icon_text_404.dart';
import 'package:blukers/views/common_views/page_template/page_template.dart';
import 'package:blukers/views/company/workers_components/chat_list_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';

import 'package:blukers/views/auth/common_widget/login_or_register.dart';

class CompanyChat extends StatelessWidget {
  const CompanyChat({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider up = Provider.of<UserProvider>(context);
    ChatProvider chatProvider = Provider.of<ChatProvider>(context);

    return PageTemplate(
        child: up.appUser == null
            ? const LoginOrRegister()
            : LayoutBuilder(
                builder: ((context, constraints) {
                  if (up.appUser != null && chatProvider.chatRooms.isEmpty) {
                    chatProvider.getGroups(up.appUser?.uid ?? "");
                  }
                  return Container(
                    child: chatProvider.chatRooms.isEmpty
                        ? IconText404(
                            text: AppLocalizations.of(context)!.youHaveNoChats,
                            icon: UniconsLine.chat)
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
                                      .where((element) =>
                                          element != up.appUser!.uid)
                                      .toList();
                                  chatProvider.chatDetails["roomId"] =
                                      chatProvider.chatRooms[index].id;
                                  chatProvider.chatDetails["sentToId"] =
                                      sentToId[0];
                                  chatProvider.chatDetails["roomName"] = up
                                              .appUser!.uid ==
                                          chatProvider
                                              .chatRooms[index].members[0]
                                      ? chatProvider.chatRooms[index].names[1]
                                      : chatProvider.chatRooms[index].names[0];
                                  context.push('/chat-message');
                                },
                              );
                            }),
                  );
                }),
              ));
  }
}
