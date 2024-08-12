import 'package:blukers/utils/styles/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../models/job_post.dart';
import '../../../../../../providers/job_posts_provider.dart';

class DeleteDialog extends StatelessWidget {
  const DeleteDialog({
    super.key,
    required this.jobPost,
  });

  final JobPost jobPost;

  @override
  Widget build(BuildContext context) {
    JobPostsProvider jp = Provider.of<JobPostsProvider>(context, listen: false);
    return AlertDialog(
      title: const Text('Confirm Deletion'),
      content: const Text('Are you sure you want to delete this job post?'),
      actions: <Widget>[
        TextButton(
          child: const Text('No',
              style: TextStyle(color: ThemeColors.primaryThemeColor)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text('Yes',
              style: TextStyle(color: ThemeColors.secondaryThemeColor)),
          onPressed: () {
            jp.deleteJobPost(jobPost.jobPostId).then((_) {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Job Post Deleted Successfully')),
              );
            }).catchError((error) {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Failed to delete job post')),
              );
            });
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
