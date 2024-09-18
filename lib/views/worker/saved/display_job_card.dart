import 'package:blukers/utils/styles/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../common_files/constants.dart';
import '../../../models/job_post.dart';
import '../../../providers/job_posts_provider.dart';
import '../../../services/rounded_image.dart';
import 'grey_container.dart';
import 'time_ago_and_bookmark_row.dart';

class DisplayJobCard extends StatefulWidget {
  final JobPost jobPost;
  final VoidCallback? onTap;

  const DisplayJobCard({
    super.key,
    this.onTap,
    required this.jobPost,
  });

  @override
  _DisplayJobCardState createState() => _DisplayJobCardState();
}

class _DisplayJobCardState extends State<DisplayJobCard> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    JobPostsProvider jp = Provider.of<JobPostsProvider>(context);

    bool isJobPostSelected() {
      return jp.selectedJobPost?.jobPostId == widget.jobPost.jobPostId;
    }

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: InkWell(
        hoverColor: Colors.transparent,
        onTap: widget.onTap,
        child: Transform(
          transform: Matrix4.translationValues(0, _isHovering ? -5 : 0, 0),
          child: Card(
            elevation: _isHovering ? 10 : 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(
                  width: isJobPostSelected() ? 2 : 1,
                  color: isJobPostSelected()
                      ? const Color(0xFF1E75BB).withOpacity(.20)
                      : Colors.black.withOpacity(.2)),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: AnimatedContainer(
                // padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: isJobPostSelected()
                      ? const Color(0xFFEEF7FF)
                      : Colors.white,
                ),
                duration: const Duration(milliseconds: 500),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                          bottom: 15, top: 20, right: 25, left: 25),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: isJobPostSelected()
                                ? const Color(0xFF1E75BB).withOpacity(.20)
                                : Colors.black.withOpacity(.2),
                            width: isJobPostSelected() ? 2 : 1,
                          ),
                        ),
                      ),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RoundedImageWidget(
                              size: 40,
                              imageUrl: widget.jobPost.companyLogo,
                              firstChar:
                                  getFirstChar(widget.jobPost.companyName),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  FittedBox(
                                    child: Text(
                                      toTitleCase(widget.jobPost.jobTitle),
                                      style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 22,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    widget.jobPost.companyName,
                                    style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                        color: ThemeColors.primaryThemeColor),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 10),
                            SavedJobsIcon(jobPost: widget.jobPost)
                          ]),
                    ),
                    // TimeAgoAndBookMarkRow(jobPost: widget.jobPost),
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 20, left: 20, bottom: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.location_on_outlined,
                                  size: 12,
                                  color: ThemeColors.black1ThemeColor),
                              const SizedBox(width: 5),
                              FittedBox(
                                child: Text(
                                  widget.jobPost.location ?? "--",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.montserrat(
                                    fontSize: 14,
                                    color: ThemeColors.black1ThemeColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Wrap(
                            spacing: 10,
                            children: [
                              widget.jobPost.salaryAmount == 0
                                  ? GreyContainer(
                                      child: AppLocalizations.of(context)!
                                          .notSpecified,
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
                          const SizedBox(height: 16),
                          Text(
                            widget.jobPost.timeAgo,
                            style: GoogleFonts.montserrat(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: isJobPostSelected()
                                  ? const Color.fromRGBO(0, 35, 65, 1)
                                  : const Color(0xFF000000),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
