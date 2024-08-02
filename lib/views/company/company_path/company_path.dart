import 'package:blukers/views/company/company_path/desktop_company_path.dart';
import 'package:blukers/views/company/company_path/mobile_company_path.dart';
import 'package:flutter/material.dart';

class CompanyPath extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    if (width >= 600) {
      // If width is 600 or more, use DesktopLayout
      return DesktopCompanyPath();
    } else {
      // Otherwise, use MobileLayout
      return MobileCompanyPath();
    }
  }
}
