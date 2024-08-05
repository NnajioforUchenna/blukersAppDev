import 'package:blukers/providers/user_provider_parts/user_provider.dart';
import 'package:blukers/services/responsive.dart';
import 'package:blukers/views/auth/common_widget/login_or_register.dart';
import 'package:blukers/views/worker/worker_chat/mobile_worker_chat/components/worker_chat_list.dart';
import 'package:blukers/views/worker/worker_chat/web_worker_chat/web_worker_chat_interface.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WorkerChat extends StatelessWidget {
  const WorkerChat({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider up = Provider.of<UserProvider>(context);
    return up.appUser == null
        ? const LoginOrRegister()
        : Responsive.isMobile(context)
        ? const WorkerChatList()
        : const WebWorkerChat();
        // : const PleaseCreateCompanyProfile();
  }
}
