import 'package:blukers/views/common_vieiws/desktop_nav_bar_company.dart';
import 'package:blukers/views/common_vieiws/desktop_nav_bar_worker.dart';
import 'package:flutter/material.dart';

import '../../../services/responsive.dart';
import 'Components/company_app_bar.dart';
import 'Components/company_buttom_navigation_bar.dart';
// import 'Components/company_drawer.dart';

class CompanyPageTemplate extends StatelessWidget {
  final Widget child;
  const CompanyPageTemplate({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        // endDrawer: Responsive.isDesktop(context) ? null : const CompanyDrawer(),
        appBar: Responsive.isDesktop(context)
            ? const DesktopNavBarCompany()
            : const CompanyAppBar(),
        bottomNavigationBar: Responsive.isDesktop(context)
            ? null
            : const CompanyButtomNavigationBar(),
        body: Padding(
            padding:
                EdgeInsets.only(top: Responsive.isDesktop(context) ? 20 : 0),
            child: child));
  }
}
