import 'package:bulkers/utils/styles/index.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatComponent extends StatelessWidget {
  const ChatComponent(
      {super.key,
      required this.message,
      required this.isMe,
      required this.time});
  final String message;
  final bool isMe;
  final DateTime time;

  @override
  Widget build(BuildContext context) {
    return
        //  Row(
        //   mainAxisAlignment:
        //      isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        //   children: [
        // if (isMe) Flexible(child: Container()),
        Column(
      crossAxisAlignment:
          isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Row(
             mainAxisAlignment:
             isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Flexible(
              child: Container(
                // width: MediaQuery.of(context).size.width * 3 / 4,
                //constraints: const BoxConstraints(maxWidth: 300),
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color:
                        isMe ? ThemeColors.chatScreenBackgroundColor : Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(42),
                      topRight: const Radius.circular(42),
                      bottomLeft: Radius.circular(isMe ? 42 : 0),
                      bottomRight: Radius.circular(isMe ? 0 : 42),
                    )),
                child: Text(
                  message,
                  // overflow: TextOverflow.ellipsis,
                  style: ThemeTextStyles.headingThemeTextStyle
                      .apply(color: isMe ? Colors.white : Colors.black),
                ),
              ),
            ),
          ],
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 12),
          // alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
          child: Text(
            DateFormat.jm().format(time),
            textAlign: isMe ? TextAlign.right : TextAlign.left,
            style: const TextStyle(color: Colors.grey),
            // style: ThemeTextStyles.headingThemeTextStyle
            //     .apply(color: Colors.white),
          ),
        ),
      ],
    );
    //   ],
    // );
  }
}
