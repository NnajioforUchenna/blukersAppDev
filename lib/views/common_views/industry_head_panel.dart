import 'package:bulkers/providers/user_provider.dart';
import 'package:bulkers/services/on_hover.dart';
import 'package:bulkers/services/responsive.dart';
import 'package:bulkers/utils/styles/index.dart';
import 'package:bulkers/views/common_views/applicant_count.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/industry.dart';

class IndustryHeadPanel extends StatelessWidget {
  final Industry industry;
  const IndustryHeadPanel({super.key, required this.industry});

  @override
  Widget build(BuildContext context) {
    UserProvider up = Provider.of<UserProvider>(context);
    return OnHover(
      child: Row(
        children: [
          Image.network(
            industry.imageUrl!,
            width: Responsive.isDesktop(context) ? 70 : 50,
          ),
          const SizedBox(width: 20),
          Text(
            industry.name,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: ThemeColors.grey1ThemeColor,
            ),
          ),
          // const Spacer(),
          // ApplicantCount(
          //   count: up.userRole == 'company'
          //       ? industry.getApplicantCount()
          //       : industry.getNumberOfJobPosts(),
          //   color: ThemeColors.grey1ThemeColor,
          // ),
        ],
      ),
    );
  }
}
