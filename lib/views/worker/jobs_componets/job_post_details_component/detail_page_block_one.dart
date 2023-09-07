import 'package:blukers/providers/user_provider.dart';
import 'package:blukers/services/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../common_files/constants.dart';
import '../../../../models/job_post.dart';
import '../../../../services/rounded_image.dart';
import '../../../../utils/styles/theme_colors.dart';
import '../../../common_views/job_timeline/display_job_timeline_dialog.dart';
import '../../../membership/show_subscription_dialog.dart';

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
                          size: 30,
                        ))
              ],
            ),
            SizedBox(height: 15.h),
            Text(
              toTitleCase(jobPost.jobTitle),
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 5.h),
            Row(
              children: [
                Text(
                  jobPost.salaryAmount.toString(),
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
                ),
                SizedBox(width: 5.h),
                Text(
                  getSalaryType(jobPost.salaryType) ?? '',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
                ),
              ],
            ),
            SizedBox(height: 15.h),
            Wrap(
              children: [
                Text("${AppLocalizations.of(context)!.company}: ",
                    style: TextStyle(fontSize: 11, color: Colors.grey)),
                Text(
                  jobPost.companyName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            SizedBox(height: 5.h),
            jobPost.address == null
                ? Text(AppLocalizations.of(context)!.notSpecified,
                    style: TextStyle(fontSize: 11, color: Colors.grey))
                : Text(
                    jobPost.address!.location ?? '',
                    style: TextStyle(fontSize: 11),
                  ),
            SizedBox(height: 15.h),
            Row(
              children: [
                const Spacer(),
                Responsive.isMobile(context)
                    ? RoundedImageWidget(
                        size: Responsive.isMobile(context) ? 50 : 100,
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
                        width: 100,
                        height: 40,
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
                          onPressed: () async {
                            if (up.workerTimelineStep < 2) {
                              showDialog(
                                  context: context,
                                  builder: (context) =>
                                      const DisplayJobTimelineDialog());
                            } else {
                              up.applyForJobPost(jobPost);
                              bool result = await up.checkIfSubscribed();
                              if (!result) {
                                showDialog(
                                    context: context,
                                    builder: (context) =>
                                        showSubscriptionDialog());
                              }
                            }
                          },
                          child: Center(
                            // Center the text inside the button
                            child: Text(
                              isJobApplied
                                  ? AppLocalizations.of(context)!
                                      .apply
                                      .toUpperCase()
                                  : AppLocalizations.of(context)!
                                      .alreadyApplied,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ),
                        ),
                      ),

                const Spacer(), // Add space between button and image
                Responsive.isMobile(context)
                    ? Container()
                    : RoundedImageWidget(
                        size: Responsive.isMobile(context) ? 50 : 100,
                        imageUrl: jobPost.companyLogo ??
                            'https://picsum.photos/200/300',
                      ),
              ],
            ),
            SizedBox(height: 15.h),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
