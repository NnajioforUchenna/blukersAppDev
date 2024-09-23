import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../common_files/constants.dart';
import '../../../../models/job_post.dart';

class DetailPageBlockSix extends StatelessWidget {
  final JobPost jobPost;
  const DetailPageBlockSix({super.key, required this.jobPost});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0.r), // Responsive padding
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Align content to start
          children: [
            Text(AppLocalizations.of(context)!.requirements,
                style: GoogleFonts.montserrat(
                    fontSize: 20,
                    fontWeight: FontWeight.w600)), // Responsive font size
            SizedBox(height: 10.h), // Responsive height
            displayParagraph(jobPost.requirements),
            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }
}
