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
    final bool isDesktop = Responsive.isDesktop(context);
    final double maxWidth = 1200.0; // Set a max width for web

    return Scaffold(
      endDrawer: isDesktop
          ? Align(
              alignment: Alignment.centerRight,
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: maxWidth),
                child: const CompanyDrawer(),
              ),
            )
          : const CompanyDrawer(),
      appBar: isDesktop
          ? PreferredSize(
              preferredSize: Size(maxWidth, 56.0), // or whatever size you want
              child: Align(
                alignment: Alignment.center,
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: maxWidth),
                  child: const CompanyAppBar(),
                ),
              ),
            )
          : PreferredSize(
              preferredSize:
                  const Size.fromHeight(56.0), // or whatever size you want
              child: const CompanyAppBar(),
            ),
      bottomNavigationBar:
          isDesktop ? null : const CompanyButtomNavigationBar(),
      body: Center(
        child: ConstrainedBox(
          constraints: isDesktop
              ? BoxConstraints(maxWidth: maxWidth)
              : const BoxConstraints(),
          child: child,
        ),
      ),
    );
  }
}
