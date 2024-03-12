import 'package:blukers/providers/app_versions_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../../services/responsive.dart';
import '../../common_vieiws/policy_terms/policy_terms_components/my_app_bar.dart';
import 'page_template_components/my_buttom_navigation_bar.dart';
import 'page_template_components/my_navigation_rail.dart';

class PageTemplate extends StatelessWidget {
  final Widget child;

  PageTemplate({
    super.key,
    required this.child,
    this.showAppBar = false,
    this.showAppBarBackButton = true,
    this.appBarTitle = '',
  });

  bool showAppBar;
  bool showAppBarBackButton;
  String appBarTitle;

  @override
  Widget build(BuildContext context) {
    AppSettingsProvider asp = Provider.of<AppSettingsProvider>(context);
    return Scaffold(
      appBar: showAppBar
          ? MyAppBar(
              title: appBarTitle,
              showLeading: showAppBarBackButton,
            )
          : null,
      bottomNavigationBar: Responsive.isDesktop(context)
          ? null
          : Showcase(
              key: asp.bottomNavigation,
              description: 'This is the bottom navigation bar',
              child: const MyButtomNavigationBar()),
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
