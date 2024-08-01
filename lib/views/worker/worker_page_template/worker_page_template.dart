import 'package:blukers/views/worker/worker_page_template/Components/worker_app_bar.dart';
import 'package:blukers/views/worker/worker_page_template/Components/worker_drawer.dart';
import 'package:flutter/material.dart';

import '../../../services/responsive.dart';
import 'Components/worker_buttom_navigation_bar.dart';
import 'Components/worker_navigation_rail.dart';

class WorkerPageTemplate extends StatelessWidget {
  final Widget child;

  const WorkerPageTemplate({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const WorkerDrawer(),
      appBar: const WorkerAppBar(),
      bottomNavigationBar: Responsive.isDesktop(context)
          ? null
          : const WorkerButtomNavigationBar(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Responsive.isDesktop(context)) const WorkerNavigationRail(),
            Expanded(
              flex: 5,
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}
