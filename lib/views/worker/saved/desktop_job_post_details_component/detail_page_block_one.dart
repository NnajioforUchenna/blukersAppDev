import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../common_files/constants.dart';
import '../../../../models/job_post.dart';
import '../../../../providers/user_provider_parts/user_provider.dart';
import '../../../../utils/styles/theme_colors.dart';
import '../../../old_common_views/job_timeline/display_job_timeline_dialog.dart';

class DetailPageBlockOne extends StatefulWidget {
  final JobPost jobPost;

  const DetailPageBlockOne({super.key, required this.jobPost});

  @override
  State<DetailPageBlockOne> createState() => _DetailPageBlockOneState();
}

class _DetailPageBlockOneState extends State<DetailPageBlockOne> {
  @override
  Widget build(BuildContext context) {
    UserProvider up = Provider.of<UserProvider>(context);
    bool isJobApplied = !up.isJobPostApplied(widget.jobPost.jobPostId ?? '');
    bool isJobSaved = up.isJobPostSaved(widget.jobPost.jobPostId ?? '');
    bool isHideButton = up.appUser?.uid == widget.jobPost.companyId;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // TimeAgoAndBookMarkRow(jobPost: jobPost),
          // SizedBox(height: 15.h),
          Text(
            toTitleCase(widget.jobPost.jobTitle),
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w600,
              fontSize: 36,
            ),
          ),
          SizedBox(height: 10.h),

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SvgPicture.asset("assets/icons/company_icon.svg"),
              SizedBox(width: 5.h),
              Text(
                  "${widget.jobPost.companyName}, ${widget.jobPost.location ?? AppLocalizations.of(context)!.notSpecified}",
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: ThemeColors.black1ThemeColor,
                  )),
            ],
          ),
          SizedBox(height: 10.h),

          Row(
            children: [
              Row(
                children: [
                  SvgPicture.asset("assets/icons/cash_icon.svg"),
                  SizedBox(width: 5.h),
                  Text(
                    '\$ ${widget.jobPost.salaryAmount}  ${getSalaryType(widget.jobPost.salaryType)}',
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: ThemeColors.black1ThemeColor),
                  ),
                ],
              ),
              const SizedBox(width: 21),
              const DotIcon(),
              const SizedBox(width: 21),
              Row(
                children: [
                  SvgPicture.asset("assets/icons/time_icon.svg"),
                  SizedBox(width: 5.h),
                  Text(
                    getJobType(widget.jobPost.jobType),
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: ThemeColors.black1ThemeColor),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 21.h),
          Row(
            children: [
              isHideButton
                  ? const SizedBox.shrink()
                  : SizedBox(
                      width: 271,
                      height: 52,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ThemeColors.secondaryThemeColorDark,
                          elevation: 8,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () async {
                          if (isJobApplied) return;
                          up.checkAndApplyJobPost(context, widget.jobPost);
                        },
                        child: Center(
                          child: AutoSizeText(
                            isJobApplied
                                ? AppLocalizations.of(context)!.alreadyApplied
                                : AppLocalizations.of(context)!.apply,
                            style: GoogleFonts.montserrat(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 16),
                          ),
                        ),
                      ),
                    ),
              const SizedBox(width: 21),
              SizedBox(
                width: 271,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: const BorderSide(
                            color: ThemeColors.secondaryThemeColorDark)),
                  ),
                  onPressed: () async {
                    if (isJobSaved) return;
                    if (up.workerTimelineStep < 3) {
                      showDialog(
                        context: context,
                        builder: (context) => const DisplayJobTimelineDialog(),
                      );
                    } else {
                      // Show loading spinner
                      showDialog(
                        context: context,
                        barrierDismissible:
                            false, // Prevent dismissing the dialog
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(isJobSaved ? 'Saved' : 'Save',
                          style: GoogleFonts.montserrat(
                              color: ThemeColors.secondaryThemeColorDark,
                              fontWeight: FontWeight.w600,
                              fontSize: 16)),
                      const SizedBox(width: 5),
                      Icon(
                        isJobSaved ? Icons.bookmark : Icons.bookmark_border,
                        color: ThemeColors.secondaryThemeColorDark,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 15.h),
          const Divider(),
        ],
      ),
    );
  }
}

class DotIcon extends StatelessWidget {
  const DotIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 6,
      width: 6,
      decoration: const BoxDecoration(
        color: ThemeColors.secondaryThemeColorDark,
        shape: BoxShape.circle,
      ),
    );
  }
}
