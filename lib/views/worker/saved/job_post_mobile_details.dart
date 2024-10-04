import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../models/job_post.dart';
import '../../../providers/user_provider_parts/user_provider.dart';
import '../../../utils/styles/theme_colors.dart';
import '../../company/my_job_posts/my_job_posts_components/my_job_post_component/job_post_company/delete_post_dialog.dart';
import '../../old_common_views/job_timeline/display_job_timeline_dialog.dart';
import 'mobile_job_post_details_components/mobile_detail_page_block_five.dart';
import 'mobile_job_post_details_components/mobile_detail_page_block_four.dart';
import 'mobile_job_post_details_components/mobile_detail_page_block_one.dart';
import 'mobile_job_post_details_components/mobile_detail_page_block_two.dart';

class JobPostMobileDetails extends StatefulWidget {
  final JobPost jobPost;

  const JobPostMobileDetails({super.key, required this.jobPost});

  @override
  State<JobPostMobileDetails> createState() => _JobPostMobileDetailsState();
}

class _JobPostMobileDetailsState extends State<JobPostMobileDetails> {
  @override
  Widget build(BuildContext context) {
    UserProvider up = Provider.of<UserProvider>(context);
    bool isJobApplied = up.isJobPostApplied(widget.jobPost.jobPostId);
    bool isJobSaved = up.isJobPostSaved(widget.jobPost.jobPostId);
    bool isOwner = up.appUser?.uid == widget.jobPost.companyId;
    // Create a ScrollController to track the scroll position
    ScrollController scrollController = ScrollController();

    return Stack(
      children: [
        SingleChildScrollView(
          controller: scrollController,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MobileDetailPageBlockOne(jobPost: widget.jobPost),
                MobileDetailPageBlockTwo(jobPost: widget.jobPost),
                // MobileDetailPageBlockThree(jobPost: widget.jobPost),
                MobileDetailPageBlockFour(jobPost: widget.jobPost),
                MobileDetailPageBlockFive(jobPost: widget.jobPost),
                // FadeInOutWidget(
                //     child: ApplyButtonWidget(jobPost: widget.jobPost)),
                const SizedBox(height: 200),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(17),
                  bottomLeft: Radius.circular(17)),
              boxShadow: [
                BoxShadow(
                  color: Color(0x1A000000),
                  offset: Offset(0, -2),
                  blurRadius: 9,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: isOwner
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 52,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  ThemeColors.secondaryThemeColorDark,
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
                                "Edit Listing",
                                style: GoogleFonts.montserrat(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 21),
                      Expanded(
                        child: SizedBox(
                          height: 48,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  side: const BorderSide(
                                      color:
                                          ThemeColors.secondaryThemeColorDark)),
                            ),
                            onPressed: () async {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return DeleteDialog(jobPost: widget.jobPost);
                                },
                              );
                            },
                            child: Text("Delete Listing",
                                style: GoogleFonts.montserrat(
                                    color: ThemeColors.secondaryThemeColorDark,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12)),
                          ),
                        ),
                      )
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 52,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  ThemeColors.secondaryThemeColorDark,
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
                                    ? AppLocalizations.of(context)!
                                        .alreadyApplied
                                        .toUpperCase()
                                    : AppLocalizations.of(context)!.apply,
                                style: GoogleFonts.montserrat(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 21),
                      Expanded(
                        child: SizedBox(
                          height: 48,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              elevation: 8,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  side: const BorderSide(
                                      color:
                                          ThemeColors.secondaryThemeColorDark)),
                            ),
                            onPressed: () async {
                              if (isJobSaved) return;
                              if (up.workerTimelineStep < 3) {
                                showDialog(
                                  context: context,
                                  builder: (context) =>
                                      const DisplayJobTimelineDialog(),
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
                                        color:
                                            ThemeColors.secondaryThemeColorDark,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12)),
                                const SizedBox(width: 5),
                                Icon(
                                  isJobSaved
                                      ? Icons.bookmark
                                      : Icons.bookmark_border,
                                  color: ThemeColors.secondaryThemeColorDark,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
          ),
        ),
      ],
    );
  }
}
