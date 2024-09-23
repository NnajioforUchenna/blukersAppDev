import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/job_post.dart';
import '../../../providers/user_provider_parts/user_provider.dart';
import '../../../utils/styles/theme_colors.dart';
import '../../old_common_views/job_timeline/display_job_timeline_dialog.dart';

class TimeAgoAndBookMarkRow extends StatefulWidget {
  final JobPost jobPost;
  const TimeAgoAndBookMarkRow({super.key, required this.jobPost});

  @override
  _TimeAgoAndBookMarkRowState createState() => _TimeAgoAndBookMarkRowState();
}

class _TimeAgoAndBookMarkRowState extends State<TimeAgoAndBookMarkRow> {
  @override
  Widget build(BuildContext context) {
    UserProvider up = Provider.of<UserProvider>(context);
    bool isJobSaved = up.isJobPostSaved(widget.jobPost.jobPostId ?? '');
    bool isHideButton = up.appUser?.uid == widget.jobPost.companyId;

    return Row(
      children: [
        Text(widget.jobPost.timeAgo ?? ''),
        const Spacer(),
        isHideButton
            ? const SizedBox()
            : IconButton(
                onPressed: () async {
                  // if (up.workerTimelineStep < 3) {
                  //   showDialog(
                  //     context: context,
                  //     builder: (context) => const DisplayJobTimelineDialog(),
                  //   );
                  // } else {
                    // Save or unsave the job post without showing a loading spinner
                    await up.saveJobPost(widget.jobPost);

                    // Trigger rebuild to reflect the change
                    setState(() {});
                  // }
                },
                icon: Icon(
                  isJobSaved
                      ? Icons.bookmark_add
                      : Icons.bookmark_add, // Toggle icon
                  color: isJobSaved
                      ? ThemeColors.secondaryThemeColor
                      : Colors.grey,
                  size: 30,
                ),
              )
      ],
    );
  }
}

class SavedJobsIcon extends StatefulWidget {
  final JobPost jobPost;
  const SavedJobsIcon({super.key, required this.jobPost});

  @override
  _SavedJobsIconState createState() => _SavedJobsIconState();
}

class _SavedJobsIconState extends State<SavedJobsIcon> {
  @override
  Widget build(BuildContext context) {
    UserProvider up = Provider.of<UserProvider>(context);
    bool isJobSaved = up.isJobPostSaved(widget.jobPost.jobPostId ?? '');
    bool isHideButton = up.appUser?.uid == widget.jobPost.companyId;

    return isHideButton
        ? const SizedBox()
        : IconButton(
            onPressed: () async {
              if (up.workerTimelineStep < 3) {
                showDialog(
                  context: context,
                  builder: (context) => const DisplayJobTimelineDialog(),
                );
              } else {
                // Show loading spinner
                showDialog(
                  context: context,
                  barrierDismissible: false, // Prevent dismissing the dialog
                  builder: (context) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                );

                // Save or unsave the job post and wait until the action is completed
                await up.saveJobPost(widget.jobPost);

                // Close the loading spinner
                Navigator.of(context).pop();

                // Trigger rebuild to reflect the change
                setState(() {});
              }
            },
            icon: Icon(
              Icons.bookmark, // Toggle icon
              color: isJobSaved ? ThemeColors.secondaryThemeColor : Colors.grey,
              size: 30,
            ),
          );
  }
}
