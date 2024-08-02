import 'package:blukers/providers/worker_chat_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';

import '../../../../models/chat_recipient.dart';
import '../../../common_vieiws/icon_text_404.dart';
import '../components/chat_recipient_widget.dart';

class WorkerChatMobile extends StatelessWidget {
  const WorkerChatMobile({super.key});

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
