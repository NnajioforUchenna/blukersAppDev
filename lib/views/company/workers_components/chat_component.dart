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
    return Row(
      children: [
        if (isMe) Flexible(child: Container()),
        Container(
          width: MediaQuery.of(context).size.width * 3 / 4,
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: ThemeColors.primaryThemeColor,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(12),
                topRight: const Radius.circular(12),
                bottomLeft: Radius.circular(isMe ? 12 : 0),
                bottomRight: Radius.circular(isMe ? 0 : 12),
              )),
          child: Column(
            children: [
              Align(
                alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                child: Text(
                  message,
                  style: ThemeTextStyles.headingThemeTextStyle
                      .apply(color: Colors.white),
                ),
              ),
              Align(
                alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                child: Text(
                  DateFormat.jm().format(time),
                  textAlign: isMe ? TextAlign.right : TextAlign.left,
                  style: const TextStyle(color: Colors.white),
                  // style: ThemeTextStyles.headingThemeTextStyle
                  //     .apply(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
