import 'package:bulkers/providers/user_provider.dart';
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              industry.name,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            ApplicantCount(
                count: up.userRole == 'company'
                    ? industry.getApplicantCount()
                    : industry.getNumberOfJobPosts(),
                color: Colors.red),
          ],
        ),
      ],
    );
  }
}
