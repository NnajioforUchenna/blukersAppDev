import 'package:bulkers/providers/industry_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../models/job_post.dart';

class DetailPageBlockTwo extends StatelessWidget {
  final JobPost jobPost;

  const DetailPageBlockTwo({Key? key, required this.jobPost}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    IndustriesProvider ip = Provider.of<IndustriesProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(16.0), // Add padding around the column
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Align content to start
        children: [
          Row(
            children: [
              Text("About Job",
                  style:
                      TextStyle(fontSize: 17.sp, fontWeight: FontWeight.bold)),
            ],
          ),
          SizedBox(height: 15.h),
          RichText(
            text: TextSpan(
              style: TextStyle(
                  fontSize: 14.sp, color: Colors.black), // Default style
              children: [
                TextSpan(
                    text: "Industry: ",
                    style: TextStyle(fontSize: 11.sp, color: Colors.grey)),
                TextSpan(
                    text: "${ip.getIndustryName(jobPost.industryIds ?? '')}"),
              ],
            ),
          ),
          SizedBox(height: 15.h),
          RichText(
            text: TextSpan(
              style: TextStyle(
                  fontSize: 14.sp, color: Colors.black), // Default style
              children: [
                TextSpan(
                    text: "Job Position: ",
                    style: TextStyle(fontSize: 11.sp, color: Colors.grey)),
                TextSpan(text: "${ip.getJobName(jobPost.jobIds ?? '')}"),
              ],
            ),
          ),
          SizedBox(height: 15.h),
          RichText(
            text: TextSpan(
              style: TextStyle(
                  fontSize: 14.sp, color: Colors.black), // Default style
              children: [
                TextSpan(
                    text: "Skills: ",
                    style: TextStyle(fontSize: 11.sp, color: Colors.grey)),
                TextSpan(text: jobPost.skills.join(', ')),
              ],
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
