import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
              CrossAxisAlignment.start, // Align content to start
          children: [
            Text(AppLocalizations.of(context)!.description,
                style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold)), // Responsive font size
            SizedBox(height: 15.h), // Responsive height
            displayParagraph(jobPost.jobDescription ?? ''),
            SizedBox(height: 15.h),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
