import 'package:blukers/views/common_vieiws/all_search_bar_components/company_desktop_search_bar.dart';
import 'package:blukers/views/common_vieiws/all_search_bar_components/company_mobile_search_bar.dart';
import 'package:flutter/material.dart';

import '../../../services/responsive.dart';

class AllCompanySearchBar extends StatefulWidget {
  const AllCompanySearchBar({super.key});

  @override
  State<AllCompanySearchBar> createState() => _AllCompanySearchBarState();
}

class _AllCompanySearchBarState extends State<AllCompanySearchBar> {
  @override
  Widget build(BuildContext context) {
    return const Responsive(
      mobile: CompanyMobileSearchBar(),
      desktop: CompanyDesktopSearchBar(),
    );
  }
}
