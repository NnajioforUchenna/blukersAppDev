import 'package:bulkers/providers/user_provider.dart';
import 'package:bulkers/views/common_views/applicant_count.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/industry.dart';

import '../../../utils/styles/index.dart';

class IndustryHeadPanel extends StatelessWidget {
  final Industry industry;
  const IndustryHeadPanel({super.key, required this.industry});

  @override
  Widget build(BuildContext context) {
    UserProvider up = Provider.of<UserProvider>(context);
    return Container(
      // color: Colors.red,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                industry.name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: ThemeColors.grey1ThemeColor,
                ),
              ),
              Spacer(),
              ApplicantCount(
                  count: up.userType == 'company'
                      ? industry.getApplicantCount()
                      : industry.getNumberOfJobPosts(),
                  color: ThemeColors.grey1ThemeColor,
                ),
            ],
          ),
        ],
      )
    );
  }
}
