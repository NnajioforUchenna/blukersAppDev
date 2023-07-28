import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/industry_provider.dart';
import '../common_views/display_industries.dart';
import '../common_views/loading_page.dart';
import '../common_views/page_template/page_template.dart';

class Jobs extends StatelessWidget {
  const Jobs({super.key});

  @override
  Widget build(BuildContext context) {
    IndustriesProvider ip = Provider.of<IndustriesProvider>(context);
    return PageTemplate(
      child: ip.industries.isEmpty ? LoadingPage() : const DisplayIndustries(),
    );
  }
}
