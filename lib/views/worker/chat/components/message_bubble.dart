import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessageBubble extends StatelessWidget {
  final String text;
  final bool isMe;
  final String receiverUserName;
  @override
  final Key key;

  const MessageBubble({
    required this.key,
    required this.text,
    required this.isMe,
    required this.receiverUserName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: EdgeInsets.all(10.r),
        child: Column(
          crossAxisAlignment:
          isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: <Widget>[
            Material(
              borderRadius: isMe
                  ? BorderRadius.only(
                topLeft: const Radius.circular(10),
                topRight: Radius.circular(10.r),
                bottomLeft: Radius.circular(10.r),
              )
                  : const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              elevation: 5.0,
              color: isMe ? Colors.blue : Colors.orange,
              child: Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                child: Text(
                  text,
                  style: const TextStyle(
                    color: Colors.green,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Key>('key', key));
    properties.add(DiagnosticsProperty<Key>('key', key));
  }
}