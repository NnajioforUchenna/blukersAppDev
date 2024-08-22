import 'package:blukers/providers/user_provider_parts/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';

import '../../../../../models/chat_recipient.dart';
import '../../../../../providers/company_chat_provider.dart';
import '../../../../common_vieiws/icon_text_404.dart';
import 'web_chat_recipient_widget.dart';

class WebCompanyChatList extends StatefulWidget {
  const WebCompanyChatList({super.key});

  @override
  State<WebCompanyChatList> createState() => _WebCompanyChatListState();
}

class _WebCompanyChatListState extends State<WebCompanyChatList> {
  @override
  Widget build(BuildContext context) {
    UserProvider up = Provider.of<UserProvider>(context);
    CompanyChatProvider cp = Provider.of<CompanyChatProvider>(context);

    return StreamBuilder<List<ChatRecipient>>(
      stream: cp.getChatRecipientsStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return IconText404(
            text: AppLocalizations.of(context)!.youHaveNoChats,
            icon: UniconsLine.chat,
          );
        }
        return ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            return WebChatRecipientWidget(
              chatRecipient: snapshot.data![index],
              // chatRecipient: cp.chatRecipients[index],
            );
          },
        );
      },
    );
  }
}
