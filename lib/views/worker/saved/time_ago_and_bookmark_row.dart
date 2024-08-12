import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/job_post.dart';
import '../../../providers/user_provider_parts/user_provider.dart';
import '../../../utils/styles/theme_colors.dart';
import '../../old_common_views/job_timeline/display_job_timeline_dialog.dart';

class TimeAgoAndBookMarkRow extends StatelessWidget {
  final JobPost jobPost;
  const TimeAgoAndBookMarkRow({super.key, required this.jobPost});

  @override
  Widget build(BuildContext context) {
    UserProvider up = Provider.of<UserProvider>(context);
    bool isJobSaved = up.isJobPostSaved(jobPost.jobPostId ?? '');
    bool isHideButton = up.appUser?.uid == jobPost.companyId;
    return Row(
      children: [
        Text(jobPost.timeAgo ?? ''),
        const Spacer(),
        isHideButton
            ? const SizedBox()
            : IconButton(
                onPressed: () {
                  if (up.workerTimelineStep < 3) {
                    showDialog(
                        context: context,
                        builder: (context) => const DisplayJobTimelineDialog());
                  } else {
                    up.saveJobPost(jobPost);
                  }
                },
                icon: Icon(
                  Icons.bookmark_add,
                  color: isJobSaved
                      ? ThemeColors.secondaryThemeColor
                      : Colors.grey,
                  size: 30,
                ))
      ],
    );
  }
}
