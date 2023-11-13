import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/industry_provider.dart';
import 'mobile_industry_headpanel.dart';

class MobileListIndustries extends StatelessWidget {
  const MobileListIndustries({super.key});

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
