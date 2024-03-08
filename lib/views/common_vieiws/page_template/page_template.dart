import '../../../providers/industry_provider.dart';
import '../../../services/responsive.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
