import 'package:blukers/providers/job_posts_provider.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:blukers/utils/styles/index.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../../../models/job_post.dart';

class DeleteJobDialog extends StatelessWidget {
  const DeleteJobDialog({
    Key? key,
    required this.jobPost,
  }) : super(key: key);

  final JobPost jobPost;

  @override
  Widget build(BuildContext context) {
    JobPostsProvider jp = Provider.of<JobPostsProvider>(context, listen: false);
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.delete_outline,
              color: Colors.deepOrange,
              size: 48,
            ),
            const SizedBox(height: 16),
            const Text(
              'Delete this Job Post?',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Deleting this job will remove it from the blukers app. Are you sure you want to delete?',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.deepOrange),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(color: Colors.deepOrange),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    onPressed: () {
                      jp.deleteJobPost(jobPost.jobPostId);
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Delete now',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// title: const Text('Confirm Deletion'),
//       content: const Text('Are you sure you want to delete this job post?'),
//       actions: <Widget>[
//         TextButton(
//           child: const Text('No',
//               style: TextStyle(color: ThemeColors.primaryThemeColor)),
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//         ),
//         TextButton(
//           child: const Text('Yes',
//               style: TextStyle(color: ThemeColors.secondaryThemeColor)),
//           onPressed: () {
//             jp.deleteJobPost(jobPost.jobPostId).then((_) {
//               Navigator.of(context).pop();
//               ScaffoldMessenger.of(context).showSnackBar(
//                 const SnackBar(content: Text('Job Post Deleted Successfully')),
//               );
//             }).catchError((error) {
//               Navigator.of(context).pop();
//               ScaffoldMessenger.of(context).showSnackBar(
//                 const SnackBar(content: Text('Failed to delete job post')),
//               );
//             });
//             Navigator.of(context).pop();
//           },
//         ),
//       ],