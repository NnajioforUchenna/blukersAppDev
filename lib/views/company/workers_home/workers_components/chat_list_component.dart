import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../models/chat_room.dart';
import '../../../../providers/user_provider_parts/user_provider.dart';
import '../../../../utils/styles/theme_text_styles.dart';

class ChatListComponent extends StatelessWidget {
  const ChatListComponent(
      {super.key, required this.chatRoom, required this.onTap});
  final ChatRoom chatRoom;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    UserProvider up = Provider.of<UserProvider>(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 120,
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
            color: Colors.grey[200], borderRadius: BorderRadius.circular(20)),
        child: Row(
          children: [
            SizedBox(
              width: 100,
              height: 100,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: up.appUser!.uid == chatRoom.members[0]
                    ? chatRoom.chatLogo[1] != ""
                        ? FadeInImage.assetNetwork(
                            placeholder: "assets/images/loading.jpeg",
                            image: chatRoom.chatLogo[1],
                            //width: MediaQuery.of(context).size.width,
                            fit: BoxFit.cover,
                          )
                        : Image.asset("assets/images/userDefaultProfilePic.png")
                    : chatRoom.chatLogo[0] != ""
                        ? FadeInImage.assetNetwork(
                            placeholder: "assets/images/loading.jpeg",
                            image: chatRoom.chatLogo[0],
                            //width: MediaQuery.of(context).size.width,
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            "assets/images/userDefaultProfilePic.png"),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    up.appUser!.uid == chatRoom.members[0]
                        ? chatRoom.names[1]
                        : chatRoom.names[0],
                    style: ThemeTextStyles.headingThemeTextStyle,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    chatRoom.lastMessage,
                    style: ThemeTextStyles.bodyThemeTextStyle,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
