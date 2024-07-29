import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/app_settings_provider.dart';
import '../../../services/responsive.dart';
import 'Components/company_app_bar.dart';
import 'Components/company_buttom_navigation_bar.dart';
import 'Components/company_drawer.dart';
import 'Components/company_navigation_rail.dart';

class CompanyPageTemplate extends StatelessWidget {
  final Widget child;
  const CompanyPageTemplate({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    AppSettingsProvider asp = Provider.of<AppSettingsProvider>(context);
    return Scaffold(
      key: asp.scaffoldKey,
      endDrawer: const CompanyDrawer(),
      appBar: const CompanyAppBar(),
      bottomNavigationBar: Responsive.isDesktop(context)
          ? null
          : const CompanyButtomNavigationBar(),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (Responsive.isDesktop(context))
                    const Expanded(
                      child: CompanyNavigationRail(),
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
