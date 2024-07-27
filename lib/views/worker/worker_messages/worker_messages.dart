import 'package:blukers/services/responsive.dart';
import 'package:flutter/material.dart';

import 'desktop_worker_messages.dart';
import 'mobile_worker_messages.dart';

class WorkerMessages extends StatelessWidget {
  const WorkerMessages({super.key});

  @override
  Widget build(BuildContext context) {
    return Responsive.isMobile(context)
        ? const MobileWorkerMessages()
        : const DesktopWorkerMessages();
  }
}
