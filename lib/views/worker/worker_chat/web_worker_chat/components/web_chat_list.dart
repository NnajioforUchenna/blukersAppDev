import 'package:blukers/models/chat_recipient.dart';
import 'package:blukers/providers/user_provider_parts/user_provider.dart';
import 'package:blukers/providers/worker_chat_provider.dart';
import 'package:blukers/views/common_vieiws/icon_text_404.dart';
import 'package:blukers/views/worker/worker_chat/web_worker_chat/components/web_chat_recipient_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';

class WebWorkerChatList extends StatefulWidget {
  const WebWorkerChatList({super.key});

  @override
  State<WebWorkerChatList> createState() => _WebWorkerChatListState();
}

class _WebWorkerChatListState extends State<WebWorkerChatList> {
  @override
  Widget build(BuildContext context) {
    UserProvider up = Provider.of<UserProvider>(context);
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
            return ChatRecipientProfile(
              chatRecipient: snapshot.data![index],
              // chatRecipient: cp.chatRecipients[index],
            );
          },
        );
      },
    );
  }
}
