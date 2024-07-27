import 'package:blukers/providers/app_settings_provider.dart';
import 'package:blukers/views/common_vieiws/page_template/page_template_components/my_app_bar.dart';
import 'package:blukers/views/common_vieiws/page_template/page_template_components/my_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../services/responsive.dart';
import 'page_template_components/my_buttom_navigation_bar.dart';
import 'page_template_components/my_navigation_rail.dart';

class PageTemplate extends StatelessWidget {
  final Widget child;

  PageTemplate({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    AppSettingsProvider asp = Provider.of<AppSettingsProvider>(context);
    return Scaffold(
      key: asp.scaffoldKey,
      endDrawer: const MyDrawer(),
      appBar: const MyAppBar(),
      bottomNavigationBar:
          Responsive.isDesktop(context) ? null : const MyButtomNavigationBar(),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (Responsive.isDesktop(context))
                    const Expanded(
                      child: MyNavigationRail(),
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
