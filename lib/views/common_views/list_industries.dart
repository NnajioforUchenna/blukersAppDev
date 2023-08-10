import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/industry_provider.dart';
import 'display_industry.dart';

class ListIndustries extends StatelessWidget {
  const ListIndustries({super.key});

  @override
  Widget build(BuildContext context) {
    IndustriesProvider ip = Provider.of<IndustriesProvider>(context);

    return Column(
      children: ip.industries.values.map((industry) {
        return DisplayIndustry(
          industry: industry,
        );
      }).toList(),
    );
  }
}
