import 'package:blukers/providers/company_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../models/job_post.dart';
import '../../../../../providers/user_provider_parts/user_provider.dart';

class TimeAgoAndBookMarkRowCompany extends StatelessWidget {
  final JobPost jobPost;

  const TimeAgoAndBookMarkRowCompany({super.key, required this.jobPost});

  @override
  Widget build(BuildContext context) {
    UserProvider up = Provider.of<UserProvider>(context);
    CompanyProvider cp = Provider.of<CompanyProvider>(context);
    bool isHideButton = up.appUser?.uid == jobPost.companyId;

    return Row(
      children: [
        Text(jobPost.timeAgo ?? ''),
        const Spacer(),
        isHideButton
            ? const SizedBox()
            : IconButton(
                onPressed: () {
                  String? loggedInUserId = cp.appUser?.uid;
                  if (loggedInUserId != null) {
                    up.saveOtherCompanyJobPosts(jobPost);
                  }
                },
                icon: Icon(
                  Icons.bookmark_add,
                  // color: isJobPostSaved
                  //     ? ThemeColors.secondaryThemeColor
                  //     : Colors.grey,
                  size: 30,
                ),
              )
      ],
    );
  }
}
