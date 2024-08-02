import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';

import '../../../providers/chat_provider.dart';
import '../../../providers/user_provider_parts/user_provider.dart';
import '../../auth/common_widget/login_or_register.dart';
import '../../common_vieiws/icon_text_404.dart';
import '../../worker/worker_chat/components/chat_recipient_widget.dart';

class CompanyChat extends StatelessWidget {
  const CompanyChat({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider up = Provider.of<UserProvider>(context);
    ChatProvider cp = Provider.of<ChatProvider>(context);

    return up.appUser == null
        ? const LoginOrRegister()
        : LayoutBuilder(
            builder: ((context, constraints) {
              return cp.chatRecipients.isEmpty
                  ? IconText404(
                      text: AppLocalizations.of(context)!.youHaveNoChats,
                      icon: UniconsLine.chat)
                  : ListView.builder(
                      itemCount: cp.chatRecipients.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ChatRecipientWidget(
                          chatRecipient: cp.chatRecipients[index],
                        );
                      });
            }),
          );
  }
}
