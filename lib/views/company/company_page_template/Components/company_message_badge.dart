import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/company_chat_provider.dart';
import 'company_message_badge_animation.dart';

class CompanyMessageBadge extends StatelessWidget {
  const CompanyMessageBadge({super.key});

  @override
  Widget build(BuildContext context) {
    CompanyChatProvider cp = Provider.of<CompanyChatProvider>(context);
    int messageCount = cp.unreadMessageCount;
    return messageCount == 0
        ? Container()
        : CompanyMessageBadgeAnimation(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.red,
          ),
          alignment: Alignment.center,
          child: Text(
            messageCount.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
