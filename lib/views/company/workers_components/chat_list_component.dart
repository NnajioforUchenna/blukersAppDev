import 'package:bulkers/models/chat_room.dart';
import 'package:bulkers/providers/user_provider.dart';
import 'package:bulkers/utils/styles/theme_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
                child: chatRoom.chatLogo[1] != "" && chatRoom.chatLogo[0] != ""
                    ? FadeInImage.assetNetwork(
                        placeholder: "assets/images/loading.jpeg",
                        image: up.appUser!.uid == chatRoom.members[0]
                            ? chatRoom.chatLogo[1]
                            : chatRoom.chatLogo[0],
                        //width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                      )
                    : Image.asset("assets/images/mockImage.png"),
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
