import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common_files/constants.dart';
import '../../../../models/job_post.dart';

import 'package:blukers/views/common_views/components/shaped_icon.dart';
import 'package:unicons/unicons.dart';

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
          Text(AppLocalizations.of(context)!.details,
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold)), // Responsive font size
          SizedBox(height: 15.h), // Responsive height
          Row(
            children: [
              const ShapedIcon(icon: UniconsLine.clock),
              SizedBox(width: 1.h),
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                  ),
                  children: [
                    TextSpan(
                        text: "${AppLocalizations.of(context)!.schedule}: ",
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color.fromARGB(255, 62, 62, 62),
                          fontFamily: 'Montserrat',
                        )),
                    TextSpan(
                        text: "${jobPost.schedule}",
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

          SizedBox(height: 20.h), // Responsive height
          Row(
            children: [
              const ShapedIcon(icon: UniconsLine.calender),
              SizedBox(width: 1.h),
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                  ),
                  children: [
                    TextSpan(
                        text: "${AppLocalizations.of(context)!.jobType}: ",
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color.fromARGB(255, 62, 62, 62),
                          fontFamily: 'Montserrat',
                        )),
                    TextSpan(
                        text: "${getJobType(jobPost.jobType)}",
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
          SizedBox(height: 15.h), // Responsive height
          Row(
            children: [
              const ShapedIcon(icon: UniconsLine.money_bill),
              SizedBox(width: 1.h),
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                  ),
                  children: [
                    TextSpan(
                        text: "${AppLocalizations.of(context)!.payment}:",
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color.fromARGB(255, 62, 62, 62),
                          fontFamily: 'Montserrat',
                        )),
                    TextSpan(
                        text:
                            " \$${jobPost.salaryAmount.toString()} ${getSalaryType(jobPost.salaryType)}",
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
