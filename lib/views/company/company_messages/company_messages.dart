import 'package:blukers/services/responsive.dart';
import 'package:blukers/views/company/company_page_template/company_page_template.dart';
import 'package:flutter/material.dart';

import 'desktop_company_messages.dart';
import 'mobile_company_messages.dart';



class CompanyMessages extends StatelessWidget {
  const CompanyMessages({super.key});

  @override
  Widget build(BuildContext context) {
    return CompanyPageTemplate(child: Responsive.isMobile(context)
        ? const MobileCompanyMessages()
        : const DesktopCompanyMessages()
    );
  }
}

