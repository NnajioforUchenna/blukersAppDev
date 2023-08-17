import 'package:bulkers/providers/user_provider.dart';
import 'package:bulkers/services/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../common_files/constants.dart';
import '../../../../models/job_post.dart';
import '../../../../services/rounded_image.dart';
import '../../../../utils/styles/theme_colors.dart';
import '../../../common_views/job_timeline/display_job_timeline_dialog.dart';

class DetailPageBlockOne extends StatelessWidget {
  final JobPost jobPost;

  const DetailPageBlockOne({Key? key, required this.jobPost}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get screen width
    double width = MediaQuery.of(context).size.width;
    UserProvider up = Provider.of<UserProvider>(context);
    bool isJobApplied = !up.isJobPostApplied(jobPost.jobPostId ?? '');
    bool isJobSaved = up.isJobPostSaved(jobPost.jobPostId ?? '');
    bool isHideButton = up.appUser?.uid == jobPost.companyId;

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
                isHideButton
                    ? SizedBox()
                    : IconButton(
                        onPressed: () {
                          if (up.workerTimelineStep < 2) {
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
                          size: 30.sp,
                        ))
              ],
            ),
            SizedBox(height: 15.h),
            Text(jobPost.jobTitle ?? '',
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
            SizedBox(height: 15.h),
            Row(
              children: [
                Text(
                  jobPost.salaryAmount.toString(),
                  style:
                      TextStyle(fontWeight: FontWeight.w700, fontSize: 13.sp),
                ),
                SizedBox(width: 5.h),
                Text(
                  getSalaryType(jobPost.salaryType) ?? '',
                  style:
                      TextStyle(fontWeight: FontWeight.w700, fontSize: 13.sp),
                ),
              ],
            ),
            SizedBox(height: 15.h),
            Text(
              getAddressesInStringFormat(jobPost.addresses),
              style: TextStyle(fontSize: 11.sp),
            ),
            SizedBox(height: 15.h),
            Row(
              children: [
                const Spacer(),
                Responsive.isMobile(context)
                    ? RoundedImageWidget(
                        size: Responsive.isMobile(context) ? 50.sp : 100.sp,
                        imageUrl: jobPost.companyLogo ??
                            'https://picsum.photos/200/300',
                      )
                    : Container(),
              ],
            ),
            SizedBox(height: 15.h),
            Row(
              children: [
                isHideButton
                    ? SizedBox()
                    : Container(
                        width: 100.sp,
                        height: 40.sp,
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
                            if (up.workerTimelineStep < 2) {
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
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16.sp),
                            ),
                          ),
                        ),
                      ),

                const Spacer(), // Add space between button and image
                Responsive.isMobile(context)
                    ? Container()
                    : RoundedImageWidget(
                        size: Responsive.isMobile(context) ? 50.sp : 100.sp,
                        imageUrl: jobPost.companyLogo ??
                            'https://picsum.photos/200/300',
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
