import 'package:blukers/providers/industry_provider.dart';
import 'package:blukers/services/responsive.dart';
import 'package:blukers/views/common_views/components/my_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'my_buttom_navigation_bar.dart';
import 'my_navigation_rail.dart';

class PageTemplate extends StatelessWidget {
  final Widget child;
  PageTemplate({
    Key? key,
    required this.child,
    this.showAppBar = false,
    this.showAppBarBackButton = true,
    this.appBarTitle = '',
  }) : super(key: key);

  bool showAppBar;
  bool showAppBarBackButton;
  String appBarTitle;

  @override
  Widget build(BuildContext context) {
    IndustriesProvider up = Provider.of<IndustriesProvider>(context);
    return Scaffold(
      appBar: showAppBar
          ? MyAppBar(
              title: appBarTitle,
              showLeading: showAppBarBackButton,
            )
          : null,
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
