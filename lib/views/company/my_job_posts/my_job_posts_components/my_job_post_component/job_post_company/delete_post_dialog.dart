import 'package:auto_size_text/auto_size_text.dart';
import 'package:blukers/utils/styles/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../../../models/job_post.dart';
import '../../../../../../providers/job_posts_provider.dart';
import '../../../../../../services/responsive.dart';

class DeleteDialog extends StatelessWidget {
  const DeleteDialog({
    super.key,
    required this.jobPost,
  });

  final JobPost jobPost;

  @override
  Widget build(BuildContext context) {
    JobPostsProvider jp = Provider.of<JobPostsProvider>(context, listen: false);
    return Dialog(
      insetPadding: Responsive.isDesktop(context)
          ? null
          : const EdgeInsets.symmetric(
              horizontal: 30,
            ),
      surfaceTintColor: Colors.white,
      backgroundColor: Colors.white,
      // contentPadding: EdgeInsets.symmetric(
      //   horizontal: Responsive.isMobile(context) ? 20 : 30,
      // ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),

      child: Container(
        width: Responsive.isMobile(context) ? null : 417,
        padding: EdgeInsets.symmetric(
          horizontal: Responsive.isMobile(context) ? 20 : 30,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(height: 24),
            SvgPicture.asset("assets/icons/delete_icon.svg"),
            const SizedBox(height: 24),
            Text(
              "Delete This Job Post",
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 16),
            ),
            const SizedBox(height: 14),
            Text(
              "Deleting this job will remove it from the blukers app. Are you sure you want to delete?",
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(color: Colors.black, fontSize: 14),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(
                  child: SizedBox(
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: const BorderSide(
                                color: ThemeColors.secondaryThemeColorDark)),
                      ),
                      onPressed: () async {
                        Navigator.of(context).pop();
                      },
                      child: Text("Cancel",
                          style: GoogleFonts.montserrat(
                              color: ThemeColors.secondaryThemeColorDark,
                              fontWeight: FontWeight.w600,
                              fontSize: 14)),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: SizedBox(
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ThemeColors.secondaryThemeColorDark,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () async {
                        jp.deleteJobPost(jobPost.jobPostId).then((_) {
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Job Post Deleted Successfully')),
                          );
                        }).catchError((error) {
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Failed to delete job post')),
                          );
                        });
                      },
                      child: Center(
                        child: AutoSizeText(
                          "Delete now",
                          style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 14),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
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