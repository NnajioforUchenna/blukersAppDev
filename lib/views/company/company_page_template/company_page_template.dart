import 'package:flutter/material.dart';

import '../../../services/responsive.dart';
import 'Components/company_app_bar.dart';
import 'Components/company_buttom_navigation_bar.dart';
import 'Components/company_drawer.dart';

class CompanyPageTemplate extends StatelessWidget {
  final Widget child;
  const CompanyPageTemplate({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        endDrawer: const CompanyDrawer(),
        appBar: const CompanyAppBar(),
        bottomNavigationBar: Responsive.isDesktop(context)
            ? null
            : const CompanyButtomNavigationBar(),
        body: child);
  }
}
