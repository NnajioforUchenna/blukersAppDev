import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';
import '../../../common_files/constants.dart';
import '../../../models/job_post.dart';
import '../../../providers/job_posts_provider.dart';
import '../../../providers/user_provider_parts/user_provider.dart';
import '../../../utils/styles/theme_colors.dart';
import '../../old_common_views/components/shaped_icon.dart';
import 'grey_container.dart';
import 'time_ago_and_bookmark_row.dart';

class SavedandapplyJobCard extends StatefulWidget {
  final JobPost jobPost;
  final VoidCallback? onTap;

  const SavedandapplyJobCard({
    super.key,
    this.onTap,
    required this.jobPost,
  });

  @override
  _DisplayJobCardState createState() => _DisplayJobCardState();
}

class _DisplayJobCardState extends State<SavedandapplyJobCard> {
  @override
  Widget build(BuildContext context) {
   final JobPost jobPost = widget.jobPost; // Assign the value here
    JobPostsProvider jp = Provider.of<JobPostsProvider>(context);
    UserProvider up = Provider.of<UserProvider>(context);
    final bool isMobileLayout =
        !kIsWeb || MediaQuery.of(context).size.width < 600;
    bool isJobApplied = up.isJobPostApplied(widget.jobPost.jobPostId ?? '');
    bool isJobSaved = up.isJobPostSaved(widget.jobPost.jobPostId ?? '');
    bool isHideButton = up.appUser?.uid == widget.jobPost.companyId;

    bool isJobPostSelected() {
      return jp.selectedJobPost?.jobPostId == widget.jobPost.jobPostId;
    }

    return InkWell(
      hoverColor: Colors.transparent,
      onTap: widget.onTap,
      child: Card(
        elevation: 4,
        child: ClipRRect(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color:
                  isJobPostSelected() ? const Color(0xFFE5EDFF) : Colors.white,
              border: isMobileLayout
                  ? const Border(
                      left: BorderSide(
                        width: 15,
                        color: ThemeColors.primaryThemeColor,
                      ),
                    )
                  : null,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 10,
                  children: [
                    widget.jobPost.salaryAmount == 0
                        ? GreyContainer(
                            child: AppLocalizations.of(context)!.notSpecified,
                          )
                        : GreyContainer(
                            child:
                                "${widget.jobPost.salaryAmount} ${getSalaryType(widget.jobPost.salaryType)}",
                          ),
                    GreyContainer(
                      child: getJobType(widget.jobPost.jobType),
                    ),
                    GreyContainer(
                      child: widget.jobPost.schedule,
                    ),
                  ],
                ),
                TimeAgoAndBookMarkRow(jobPost: widget.jobPost),
                const SizedBox(height: 8),
                Text(
                  toTitleCase(widget.jobPost.jobTitle),
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.location_on,
                      size: 16,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        widget.jobPost.location!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.montserrat(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const ShapedIcon(icon: UniconsLine.money_bill),
                    SizedBox(width: 5.h),
                    Text(
                      '\$ ${widget.jobPost.salaryAmount}',
                      style: const TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 14),
                    ),
                    SizedBox(width: 5.h),
                    Text(
                      getSalaryType(widget.jobPost.salaryType) ?? '',
                      style: const TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 14),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
             
                const SizedBox(height: 15),
                Row(
                  children: [
                    if (!isHideButton)
                      isJobApplied
                          ? Container(
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
                            )
                          : SizedBox(
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
                                  setState(() {
                                 up.checkAndApplyJobPost(context, jobPost);
                                  });
                                },
                                child: Center(
                                  child: AutoSizeText(
                                    AppLocalizations.of(context)!
                                        .apply
                                        ,
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
                            ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
