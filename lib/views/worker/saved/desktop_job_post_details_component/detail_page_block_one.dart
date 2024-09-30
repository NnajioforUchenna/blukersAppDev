import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';

import '../../../../common_files/constants.dart';
import '../../../../models/job_post.dart';
import '../../../../providers/user_provider_parts/user_provider.dart';
import '../../../../services/responsive.dart';
import '../../../../services/rounded_image.dart';
import '../../../../utils/styles/theme_colors.dart';
import '../../../old_common_views/components/shaped_icon.dart';
import '../time_ago_and_bookmark_row.dart';

class DetailPageBlockOne extends StatelessWidget {
  final JobPost jobPost;

  const DetailPageBlockOne({Key? key, required this.jobPost}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserProvider up = Provider.of<UserProvider>(context);
    bool isJobApplied = !up.isJobPostApplied(jobPost.jobPostId ?? '');
    bool isJobSaved = up.isJobPostSaved(jobPost.jobPostId ?? '');
    bool isCompanyOwner = up.appUser?.uid == jobPost.companyId;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
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
                  '\$ ${jobPost.salaryAmount}',
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
                if (isCompanyOwner) ...[
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ThemeColors.primaryThemeColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9),
                        ),
                      ),
                      onPressed: () {
                        // TODO: Implement edit functionality
                      },
                      child: const Text(
                        "Edit Listing",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                            color: ThemeColors.primaryThemeColor),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9),
                        ),
                      ),
                      onPressed: () {
                        // TODO: Implement delete functionality
                      },
                      child: const Text(
                        "Delete Listing",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: ThemeColors.primaryThemeColor,
                        ),
                      ),
                    ),
                  ),
                ] else if (!isCompanyOwner)
                  isJobApplied
                      ? SizedBox(
                          height: 40,
                          width: 150,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ThemeColors.primaryThemeColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(9),
                              ),
                            ),
                            onPressed: () async {
                              up.checkAndApplyJobPost(context, jobPost);
                            },
                            child: Center(
                              child: AutoSizeText(
                                AppLocalizations.of(context)!.apply,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                                maxLines: 1,
                                minFontSize: 12,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        )
                      : Container(
                          height: 40,
                          width: 150,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(9),
                            border: Border.all(
                                color: ThemeColors.primaryThemeColor),
                          ),
                          child: Text(
                            AppLocalizations.of(context)!.alreadyApplied,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: ThemeColors.primaryThemeColor,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                const Spacer(),
                RoundedImageWidget(
                  size: Responsive.isMobile(context) ? 50 : 100,
                  imageUrl:
                      jobPost.companyLogo ?? 'https://picsum.photos/200/300',
                  firstChar: getFirstChar(jobPost.companyName ?? ''),
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
