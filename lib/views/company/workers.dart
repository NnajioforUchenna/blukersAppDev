import 'package:bulkers/views/common_views/page_template/page_template.dart';
import 'package:bulkers/views/company/workers_components/display_industries.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/industry_provider.dart';
import '../common_views/loading_page.dart';

class Workers extends StatefulWidget {
  const Workers({super.key});

  @override
  State<Workers> createState() => _WorkersState();
}

class _WorkersState extends State<Workers> {
  @override
  Widget build(BuildContext context) {
    IndustriesProvider ip = Provider.of<IndustriesProvider>(context);
    return PageTemplate(
      child: ip.industries.isEmpty ? LoadingPage() : const DisplayIndustries(),
    );
  }
}
