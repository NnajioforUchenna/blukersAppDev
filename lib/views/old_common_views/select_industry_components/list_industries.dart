import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/industry_provider.dart';
import '../../worker/jobs_home/Components/jobs_mobile_view/jobs_mobile_view_compnents/mobile_industry_headpanel.dart';

class ListIndustries extends StatelessWidget {
  const ListIndustries({super.key});

  @override
  Widget build(BuildContext context) {
    IndustriesProvider ip = Provider.of<IndustriesProvider>(context);
    return Column(
      children: ip.industries.values.map((industry) {
        return Container(
          margin: const EdgeInsets.only(bottom: 10.0, left: 30, right: 30),
          child: MobileIndustryHeadPanel(industry: industry),
        );
      }).toList(),
    );
  }
}
