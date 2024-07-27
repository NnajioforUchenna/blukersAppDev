import 'package:blukers/providers/app_settings_provider.dart';
import 'package:blukers/views/worker/worker_page_template/Components/worker_app_bar.dart';
import 'package:blukers/views/worker/worker_page_template/Components/worker_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    AppSettingsProvider asp = Provider.of<AppSettingsProvider>(context);
    return Scaffold(
      key: asp.scaffoldKey,
      endDrawer: const WorkerDrawer(),
      appBar: const WorkerAppBar(),
      bottomNavigationBar: Responsive.isDesktop(context)
          ? null
          : const WorkerButtomNavigationBar(),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (Responsive.isDesktop(context))
                    const Expanded(
                      child: WorkerNavigationRail(),
                    ),
                  Expanded(
                    flex: 5,
                    child: child,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
