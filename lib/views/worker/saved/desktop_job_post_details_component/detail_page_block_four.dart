import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../common_files/constants.dart';
import '../../../../models/job_post.dart';

class DetailPageBlockFour extends StatelessWidget {
  final JobPost jobPost;

  const DetailPageBlockFour({super.key, required this.jobPost});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0.r), // Responsive padding
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, 
          children: [
            Text("Job Description",
                style:  GoogleFonts.montserrat(
                    fontSize: 20,
                    fontWeight: FontWeight.w600)),
            SizedBox(height: 10.h), 
            displayParagraph(jobPost.jobDescription ),
            SizedBox(height: 10.h),
         
          ],
        ),
      ),
    );
  }
}
