import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';

import '../../../../models/chat_recipient.dart';
import '../../../../providers/chat_provider.dart';
import '../../../../providers/user_provider_parts/user_provider.dart';
import '../../../common_vieiws/icon_text_404.dart';
import '../../worker_page_template/worker_page_template.dart';
import '../components/chat_recipient_widget.dart';

class WorkerChatMobile extends StatelessWidget {
  const WorkerChatMobile({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider up = Provider.of<UserProvider>(context);

    return WorkerPageTemplate(
      child: StreamBuilder<List<ChatRecipient>>(
        stream: Provider.of<ChatProvider>(context, listen: false)
            .getChatRecipientsStream(),
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
      ),
    );
  }
}