import 'dart:developer';

import 'package:blukers/views/common_vieiws/desktop_nav_bar_worker.dart';
import 'package:blukers/views/worker/worker_page_template/Components/worker_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../services/responsive.dart';
import 'Components/worker_buttom_navigation_bar.dart';

class WorkerPageTemplate extends StatelessWidget {
  final Widget child;

  const WorkerPageTemplate({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    String? currentRoute =
        GoRouter.of(context).routerDelegate.currentConfiguration.uri.path;
    log('currentRoute: $currentRoute');
    return Scaffold(
      backgroundColor: Colors.white,
      // endDrawer: Responsive.isDesktop(context) ? null : const WorkerDrawer(),
      appBar: Responsive.isDesktop(context)
          ? const DesktopNavBarWorker()
          : const WorkerAppBar(),
      bottomNavigationBar: (Responsive.isDesktop(context) ||
              currentRoute.contains('messenger') ||
              currentRoute.contains('companyChatRoomScreen'))
          ? null
          : const WorkerButtomNavigationBar(),
      body: Padding(
          padding: EdgeInsets.only(top: Responsive.isDesktop(context) ? 20 : 0),
          child: child),
    );
  }
}
