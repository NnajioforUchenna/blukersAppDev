import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';

import '../../../../../models/chat_recipient.dart';
import '../../../../../providers/company_chat_provider.dart';
import '../../../../common_vieiws/icon_text_404.dart';
import '../../company_chat_recipient_widget.dart';

class CompanyChatList extends StatefulWidget {
  const CompanyChatList({super.key});

  @override
  State<CompanyChatList> createState() => _CompanyChatListState();
}

class _CompanyChatListState extends State<CompanyChatList> {
  @override
  Widget build(BuildContext context) {
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
            return CompanyChatRecipientWidget(
              chatRecipient: snapshot.data![index],
            );
          },
        );
      },
    );
  }
}
