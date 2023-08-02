import 'package:bulkers/models/chat_room.dart';
import 'package:bulkers/utils/styles/theme_text_styles.dart';
import 'package:flutter/material.dart';

class ChatListComponent extends StatelessWidget {
  const ChatListComponent(
      {super.key, required this.chatRoom, required this.onTap});
  final ChatRoom chatRoom;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
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
                child: chatRoom.chatLogo != null && chatRoom.chatLogo != ""
                    ? FadeInImage.assetNetwork(
                        placeholder: "assets/images/loading.jpeg",
                        image: chatRoom.chatLogo!,
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
                    chatRoom.roomName,
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
