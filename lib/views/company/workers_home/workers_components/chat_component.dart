import '../../../../utils/styles/index.dart';
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
                    color: isMe ? ThemeColors.secondaryThemeColor : ThemeColors.grey2ThemeColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    )),
                child: Text(
                  message,
                  // overflow: TextOverflow.ellipsis,
                  style: ThemeTextStyles.headingThemeTextStyle
                      .apply(color: isMe ? Colors.white : Colors.black,
                      ).copyWith(fontWeight: FontWeight.w500)
                ),
              ),
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 12),
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
