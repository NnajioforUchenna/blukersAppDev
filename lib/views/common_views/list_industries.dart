import 'package:bulkers/models/industry.dart';
import 'package:bulkers/utils/styles/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/industry_provider.dart';
import 'display_industry.dart';

class ListIndustries extends StatelessWidget {
  const ListIndustries({super.key});

  @override
  Widget build(BuildContext context) {
    IndustriesProvider ip = Provider.of<IndustriesProvider>(context);

    return ListView.separated(
      itemCount: ip.industries.length,
      itemBuilder: (BuildContext context, int index) {
        List<Industry> industries = ip.industries.values.toList();
        return DisplayIndustry(
          industry: industries[index],
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return Container(
          color: ThemeColors.grey2ThemeColor,
        );
      },
    );
  }
}
