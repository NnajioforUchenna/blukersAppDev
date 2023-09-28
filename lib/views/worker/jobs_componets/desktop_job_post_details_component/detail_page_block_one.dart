import 'package:blukers/providers/user_provider.dart';
import 'package:blukers/services/responsive.dart';
import 'package:blukers/views/common_views/components/shaped_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';

import '../../../../common_files/constants.dart';
import '../../../../models/job_post.dart';
import '../../../../services/rounded_image.dart';
import '../../../../utils/styles/theme_colors.dart';
import '../time_ago_and_bookmark_row.dart';

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
            TimeAgoAndBookMarkRow(jobPost: jobPost),
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
                const ShapedIcon(icon: UniconsLine.money_bill),
                SizedBox(width: 5.h),
                Text(
                  '\$ ' + jobPost.salaryAmount.toString(),
                  style: const TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 14),
                ),
                SizedBox(width: 5.h),
                Text(
                  getSalaryType(jobPost.salaryType) ?? '',
                  style: const TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 14),
                ),
              ],
            ),
            SizedBox(height: 15.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const ShapedIcon(icon: UniconsLine.building),
                SizedBox(width: 5.h),
                Text("${AppLocalizations.of(context)!.company}: ",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      color: ThemeColors.black3ThemeColor,
                      fontFamily: 'Montserrat',
                    )),
              ],
            ),
            SizedBox(height: 5.h),
            Wrap(
              children: [
                Text(
                  jobPost.companyName,
                  style: const TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 24,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            SizedBox(height: 15.h),
            Row(
              children: [
                const ShapedIcon(icon: UniconsLine.map_marker_alt),
                SizedBox(width: 5.h),
                jobPost.address == null
                    ? Text(AppLocalizations.of(context)!.notSpecified,
                        style:
                            const TextStyle(fontSize: 18, color: Colors.grey))
                    : Text(
                        jobPost.address!.location ?? '',
                        style: const TextStyle(fontSize: 18),
                      ),
              ],
            ),
            SizedBox(height: 15.h),
            Row(
              children: [
                isHideButton
                    ? const SizedBox()
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
                            up.checkAndApplyJobPost(context, jobPost);
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
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ),
                        ),
                      ),

                const Spacer(),
                RoundedImageWidget(
                  size: Responsive.isMobile(context) ? 50 : 100,
                  imageUrl:
                      jobPost.companyLogo ?? 'https://picsum.photos/200/300',
                  firstChar: getFirstChar(jobPost.companyName ?? ''),
                ), // Add space between button and image
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
