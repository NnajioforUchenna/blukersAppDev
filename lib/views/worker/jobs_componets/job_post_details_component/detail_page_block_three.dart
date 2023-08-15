import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common_files/constants.dart';
import '../../../../models/job_post.dart';

class DetailPageBlockThree extends StatelessWidget {
  final JobPost jobPost;

  const DetailPageBlockThree({Key? key, required this.jobPost})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0.r), // Responsive padding
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Align content to start
        children: [
          Text("Details",
              style: TextStyle(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.bold)), // Responsive font size
          SizedBox(height: 15.h), // Responsive height
          RichText(
            text: TextSpan(
              style: TextStyle(fontSize: 14.sp, color: Colors.black),
              children: [
                TextSpan(
                    text: "Schedule: ",
                    style: TextStyle(fontSize: 11.sp, color: Colors.grey)),
                TextSpan(text: "${jobPost.schedule}"),
              ],
            ),
          ),
          SizedBox(height: 20.h), // Responsive height
          RichText(
            text: TextSpan(
              style: TextStyle(fontSize: 14.sp, color: Colors.black),
              children: [
                TextSpan(
                    text: "Job Type: ",
                    style: TextStyle(fontSize: 11.sp, color: Colors.grey)),
                TextSpan(text: "${getJobType(jobPost.jobType)}"),
              ],
            ),
          ),
          SizedBox(height: 15.h), // Responsive height
          RichText(
            text: TextSpan(
              style: TextStyle(fontSize: 14.sp, color: Colors.black),
              children: [
                TextSpan(
                    text: "Pay:",
                    style: TextStyle(fontSize: 11.sp, color: Colors.grey)),
                TextSpan(
                    text:
                        " \$${jobPost.salaryAmount.toString()} ${getSalaryType(jobPost.salaryType)}"),
              ],
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
