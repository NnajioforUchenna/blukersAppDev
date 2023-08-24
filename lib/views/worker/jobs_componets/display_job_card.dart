import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../common_files/constants.dart';
import '../../../models/job_post.dart';
import '../../../providers/job_posts_provider.dart';
import '../../../services/rounded_image.dart';
import '../../../utils/styles/theme_colors.dart';

class DisplayJobCard extends StatefulWidget {
  final JobPost jobPost;
  final VoidCallback? onTap;

  const DisplayJobCard({
    Key? key,
    this.onTap,
    required this.jobPost,
  }) : super(key: key);

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
        onTap: widget.onTap,
        child: Transform(
          transform: Matrix4.translationValues(0, _isHovering ? -5 : 0, 0),
          child: Card(
            elevation: _isHovering ? 10 : 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: AnimatedContainer(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: isJobPostSelected()
                    ? const Color(0xFFE5EDFF)
                    : Colors.white,
                border: const Border(
                  left: BorderSide(
                    width: 2,
                    color: ThemeColors.primaryThemeColor,
                  ),
                ),
              ),
              duration: const Duration(milliseconds: 500),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.jobPost.timeAgo!),
                  SizedBox(height: 10.sp),
                  Text(
                    toTitleCase(widget.jobPost.jobTitle),
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.sp,
                    ),
                  ),
                  const SizedBox(height: 5),
                  widget.jobPost.salaryAmount == 0
                      ? Text(AppLocalizations.of(context)!.notSpecified)
                      : Row(
                          children: [
                            Text(widget.jobPost.salaryAmount.toString()),
                            const SizedBox(width: 5),
                            Text(getSalaryType(widget.jobPost.salaryType)),
                          ],
                        ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.jobPost.companyName,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              widget.jobPost.location!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      if (width > 600) // Show logo only on larger screens
                        RoundedImageWidget(
                          imageUrl: widget.jobPost.companyLogo,
                        ),
                    ],
                  ),
                  if (width < 600)
                    Row(
                      children: [
                        Spacer(),
                        RoundedImageWidget(
                          imageUrl: widget.jobPost.companyLogo,
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
