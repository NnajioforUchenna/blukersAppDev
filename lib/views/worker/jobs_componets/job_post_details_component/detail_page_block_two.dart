import 'package:blukers/providers/industry_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
              Text(AppLocalizations.of(context)!.aboutTheJob,
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
            ],
          ),
          SizedBox(height: 15.h),
          RichText(
            text: TextSpan(
              style:
                  TextStyle(fontSize: 14, color: Colors.black), // Default style
              children: [
                TextSpan(
                    text: "${AppLocalizations.of(context)!.industry}: ",
                    style: TextStyle(fontSize: 11, color: Colors.grey)),
                TextSpan(
                    text: jobPost.industryIds.isNotEmpty
                        ? jobPost.industryIds.join(', ')
                        : AppLocalizations.of(context)!.notSpecified),
              ],
            ),
          ),
          SizedBox(height: 15.h),
          RichText(
            text: TextSpan(
              style:
                  TextStyle(fontSize: 14, color: Colors.black), // Default style
              children: [
                TextSpan(
                    text: "${AppLocalizations.of(context)!.jobPosition}: ",
                    style: TextStyle(fontSize: 11, color: Colors.grey)),
                TextSpan(
                    text: jobPost.jobIds.isNotEmpty
                        ? jobPost.jobIds.join(', ')
                        : AppLocalizations.of(context)!.notSpecified),
              ],
            ),
          ),
          SizedBox(height: 15.h),
          RichText(
            text: TextSpan(
              style:
                  TextStyle(fontSize: 14, color: Colors.black), // Default style
              children: [
                TextSpan(
                    text: "${AppLocalizations.of(context)!.skills}: ",
                    style: TextStyle(fontSize: 11, color: Colors.grey)),
                TextSpan(
                    text: jobPost.skills.isNotEmpty
                        ? jobPost.skills.join(', ')
                        : AppLocalizations.of(context)!.notSpecified),
              ],
            ),
          ),
          SizedBox(height: 15.h),
          const Divider(),
        ],
      ),
    );
  }
}
