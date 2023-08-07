import 'package:bulkers/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common_files/constants.dart';
import '../../../models/job_post.dart';
import '../../../utils/styles/theme_colors.dart';
import '../../common_views/job_timeline/display_job_timeline_dialog.dart';

class DetailPageBlockOne extends StatelessWidget {
  final JobPost jobPost;

  const DetailPageBlockOne({Key? key, required this.jobPost}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get screen width
    double width = MediaQuery.of(context).size.width;
    UserProvider up = Provider.of<UserProvider>(context);
    bool isJobApplied = !up.isJobPostApplied(jobPost.companyId ??
        ''); // Todo remember to change this to companyId to jobPostId
    bool isJobSaved = up.isJobPostSaved(jobPost.companyId ??
        ''); // Todo remember to change this to companyId to jobPostId

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0), // Add padding to the whole widget
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(jobPost.timeAgo ?? ''),
                const Spacer(),
                IconButton(
                    onPressed: () {
                      if (up.jobTimelineStep < 2) {
                        showDialog(
                            context: context,
                            builder: (context) =>
                                const DisplayJobTimelineDialog());
                      } else {
                        up.saveJobPost(jobPost);
                      }
                    },
                    icon: Icon(
                      Icons.bookmark_add,
                      color: isJobSaved
                          ? ThemeColors.secondaryThemeColor
                          : Colors.grey,
                    ))
              ],
            ),
            const SizedBox(height: 15),
            Text(jobPost.jobTitle ?? '',
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Row(
              children: [
                Text(
                  jobPost.salaryAmount.toString(),
                  style: const TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 18),
                ),
                const SizedBox(width: 5),
                Text(
                  getSalaryType(jobPost.salaryType) ?? '',
                  style: const TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Text(
              getAddressesInStringFormat(jobPost.addresses),
              style: const TextStyle(fontSize: 18),
            ),
            Row(
              children: [
                Container(
                  width: width < 600
                      ? 100
                      : 200, // 300 on mobile, 500 on web or tablet
                  height: width < 600
                      ? 40
                      : 70, // 70 on mobile, 100 on web or tablet
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isJobApplied
                          ? ThemeColors.secondaryThemeColor
                          : Colors.grey,
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      if (up.jobTimelineStep < 2) {
                        showDialog(
                            context: context,
                            builder: (context) =>
                                const DisplayJobTimelineDialog());
                      } else {
                        up.applyForJobPost(jobPost);
                      }
                    },
                    child: Center(
                      // Center the text inside the button
                      child: Text(
                        isJobApplied ? "Apply".toUpperCase() : "Applied",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                  ),
                ),

                const Spacer(), // Add space between button and image
                Image.network(
                  jobPost.companyLogo ?? 'https://picsum.photos/200/300',
                  height: 100,
                  width: 100,
                ),
              ],
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
