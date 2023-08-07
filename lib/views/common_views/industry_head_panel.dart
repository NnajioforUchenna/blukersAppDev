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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.network(
              industry.imageUrl!,
              width: Responsive.isDesktop(context) ? 70 : 55,
            ),
          ),
          SizedBox(width: Responsive.isDesktop(context) ? 25 : 10),
          Expanded(
            child: RichText(
              text: TextSpan(
                text: industry.name,
                style: TextStyle(
                  fontSize: Responsive.isDesktop(context) ? 30 : 20,
                  fontWeight: FontWeight.w500,
                  color: ThemeColors.grey1ThemeColor,
                ),
              ),
            ),
          ),
          // // Temporarily hidden, uncomment once we have enough real data.
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
