import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
            Text("Requirements",
                style: TextStyle(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.bold)), // Responsive font size
            SizedBox(height: 15.h), // Responsive height
            displayParagraph(jobPost.requirements ?? ''),
            Divider(),
          ],
        ),
      ),
    );
  }
}
