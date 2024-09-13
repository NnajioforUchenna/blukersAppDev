import 'package:blukers/views/common_vieiws/desktop_nav_bar.dart';
import 'package:blukers/views/worker/worker_page_template/Components/worker_app_bar.dart';
import 'package:flutter/material.dart';

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
    return Scaffold(
      backgroundColor: Colors.white,
      // endDrawer: Responsive.isDesktop(context) ? null : const WorkerDrawer(),
      appBar: Responsive.isDesktop(context)
          ? const DesktopNavBar()
          : const WorkerAppBar(),
      bottomNavigationBar: Responsive.isDesktop(context)
          ? null
          : const WorkerButtomNavigationBar(),
      body: Padding(
          padding: EdgeInsets.only(top: Responsive.isDesktop(context) ? 20 : 0),
          child: child),
    );
  }
}
