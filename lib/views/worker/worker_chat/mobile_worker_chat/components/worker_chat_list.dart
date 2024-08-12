import 'package:blukers/models/chat_recipient.dart';
import 'package:blukers/providers/worker_chat_provider.dart';
import 'package:blukers/views/common_vieiws/icon_text_404.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';

import '../../../../../common_files/chat_recipient_widget.dart';

class WorkerChatList extends StatefulWidget {
  const WorkerChatList({super.key});

  @override
  State<WorkerChatList> createState() => _WorkerChatListState();
}

class _WorkerChatListState extends State<WorkerChatList> {
  @override
  Widget build(BuildContext context) {
    WorkerChatProvider wcp = Provider.of<WorkerChatProvider>(context);

    return StreamBuilder<List<ChatRecipient>>(
      stream: wcp.getChatRecipientsStream(),
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
            return ChatRecipientWidget(
              chatRecipient: snapshot.data![index],
            );
          },
        );
      },
    );
  }
}
