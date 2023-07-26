import 'package:bulkers/providers/industry_provider.dart';
import 'package:bulkers/services/responsive.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'my_buttom_navigation_bar.dart';
import 'my_navigation_rail.dart';

class PageTemplate extends StatelessWidget {
  final Widget child;
  const PageTemplate({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    IndustriesProvider up = Provider.of<IndustriesProvider>(context);
    return Scaffold(
      bottomNavigationBar:
          Responsive.isDesktop(context) ? null : const MyButtomNavigationBar(),
      body: SafeArea(
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
    );
  }
}
