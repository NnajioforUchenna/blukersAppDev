import 'package:blukers/services/responsive.dart';
import 'package:blukers/views/worker/worker_chat/mobile_worker_chat/worker_chat_mobile.dart';
import 'package:blukers/views/worker/worker_chat/worker_chat_web.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/user_provider_parts/user_provider.dart';

class WorkerChatPlatforms extends StatefulWidget {
  const WorkerChatPlatforms({super.key});

  @override
  State<WorkerChatPlatforms> createState() => _WorkerChatPlatformsState();
}

class _WorkerChatPlatformsState extends State<WorkerChatPlatforms> {
  @override
  Widget build(BuildContext context) {
    UserProvider up = Provider.of<UserProvider>(context);
    return Responsive.isMobile(context)
        ? const WorkerChatMobile()
        : const WorkerChatWeb();
  }
}

//  up.appUser == null
//         ? const LoginOrRegister()
//         :