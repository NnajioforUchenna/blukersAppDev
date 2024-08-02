import '../../../../providers/industry_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../models/job_post.dart';

import 'package:unicons/unicons.dart';

import '../../../old_common_views/components/shaped_icon.dart';

class DetailPageBlockTwo extends StatelessWidget {
  final JobPost jobPost;

  const DetailPageBlockTwo({super.key, required this.jobPost});

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
                  style: const TextStyle(
                      fontSize: 17, fontWeight: FontWeight.bold)),
            ],
          ),
          SizedBox(height: 15.h),
          Row(
            children: [
              const ShapedIcon(icon: UniconsLine.hard_hat),
              SizedBox(width: 1.h),
              RichText(
                text: TextSpan(
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                  ), // Default style
                  children: [
                    TextSpan(
                        text: "${AppLocalizations.of(context)!.industry}: ",
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color.fromARGB(255, 62, 62, 62),
                          fontFamily: 'Montserrat',
                        )),
                    TextSpan(
                        text: jobPost.industryIds.isNotEmpty
                            ? jobPost.industryIds.join(', ')
                            : AppLocalizations.of(context)!.notSpecified,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          fontFamily: 'Montserrat',
                        )),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 15.h),
          Row(
            children: [
              const ShapedIcon(icon: UniconsLine.constructor),
              SizedBox(width: 1.h),
              RichText(
                text: TextSpan(
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                  ), // Default style
                  children: [
                    TextSpan(
                        text: "${AppLocalizations.of(context)!.jobPosition}: ",
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color.fromARGB(255, 62, 62, 62),
                          fontFamily: 'Montserrat',
                        )),
                    TextSpan(
                        text: jobPost.jobIds.isNotEmpty
                            ? jobPost.jobIds.join(', ')
                            : AppLocalizations.of(context)!.notSpecified,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          fontFamily: 'Montserrat',
                        )),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 15.h),
          Row(
            children: [
              const ShapedIcon(icon: UniconsLine.jackhammer),
              SizedBox(width: 1.h),
              RichText(
                text: TextSpan(
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                  ), // Default style
                  children: [
                    TextSpan(
                        text: "${AppLocalizations.of(context)!.skills}: ",
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color.fromARGB(255, 62, 62, 62),
                          fontFamily: 'Montserrat',
                        )),
                    TextSpan(
                        text: jobPost.skills.isNotEmpty
                            ? jobPost.skills.join(', ')
                            : AppLocalizations.of(context)!.notSpecified,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          fontFamily: 'Montserrat',
                        )),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 15.h),
          const Divider(),
        ],
      ),
    );
  }
}
