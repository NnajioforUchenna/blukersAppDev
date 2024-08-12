import 'grey_container.dart';
import 'time_ago_and_bookmark_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../common_files/constants.dart';
import '../../../models/job_post.dart';
import '../../../providers/job_posts_provider.dart';
import '../../../services/rounded_image.dart';
import '../../../utils/styles/theme_colors.dart';

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
    double width =
        MediaQuery.of(context).size.width; // Getting the screen width

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
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: AnimatedContainer(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: isJobPostSelected()
                      ? const Color(0xFFE5EDFF)
                      : Colors.white,
                  border: const Border(
                    left: BorderSide(
                      width: 15,
                      color: ThemeColors.primaryThemeColor,
                    ),
                  ),
                ),
                duration: const Duration(milliseconds: 500),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TimeAgoAndBookMarkRow(jobPost: widget.jobPost),
                    const SizedBox(height: 8),
                    Text(
                      toTitleCase(widget.jobPost.jobTitle),
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Wrap(
                      spacing: 10,
                      children: [
                        widget.jobPost.salaryAmount == 0
                            ? GreyContainer(
                                child:
                                    AppLocalizations.of(context)!.notSpecified,
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
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.jobPost.companyName,
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                widget.jobPost.location!,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.montserrat(),
                              ),
                            ],
                          ),
                        ),
                        Expanded(flex: 2, child: Container()),
                        Expanded(
                          flex: 1,
                          child: RoundedImageWidget(
                            imageUrl: widget.jobPost.companyLogo,
                            firstChar:
                                getFirstChar(widget.jobPost.companyName ?? ''),
                          ),
                        ),
                      ],
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
