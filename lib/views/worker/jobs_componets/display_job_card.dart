import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/job_posts_provider.dart';
import '../../../services/rounded_image.dart';
import '../../../utils/styles/theme_colors.dart';

class DisplayJobCard extends StatefulWidget {
  final String? timeAgo;
  final String? title;
  final String? salaryRange;
  final String? salaryType;
  final String? companyName;
  final String? location;
  final String? companyLogo;
  final String? jobPostId;
  final VoidCallback? onTap;

  const DisplayJobCard({
    Key? key,
    this.timeAgo,
    this.title,
    this.salaryRange,
    this.salaryType,
    this.companyName,
    this.location,
    this.companyLogo,
    this.onTap,
    this.jobPostId,
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
      return jp.selectedJobPost?.companyId == widget.jobPostId;
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
                children: [
                  Row(
                    children: [Text(widget.timeAgo!)],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        widget.title!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Text(widget.salaryRange!),
                      Text(widget.salaryType!),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.title!,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              widget.location!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      if (width > 600) // Show logo only on larger screens
                        RoundedImageWidget(
                          imageUrl: widget.companyLogo!,
                        ),
                    ],
                  ),
                  if (width < 600)
                    Row(
                      children: [
                        Spacer(),
                        RoundedImageWidget(
                          imageUrl: widget.companyLogo!,
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
