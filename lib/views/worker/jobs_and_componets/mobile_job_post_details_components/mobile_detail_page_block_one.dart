import 'package:blukers/models/job_post.dart';
import 'package:blukers/services/rounded_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../common_files/constants.dart';
import '../time_ago_and_bookmark_row.dart';

class MobileDetailPageBlockOne extends StatelessWidget {
  final JobPost jobPost;
  const MobileDetailPageBlockOne({super.key, required this.jobPost});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TimeAgoAndBookMarkRow(jobPost: jobPost),
        Text(
          toTitleCase(jobPost.jobTitle),
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        SizedBox(height: 18),
        Row(children: [
          Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    jobPost.companyName,
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  jobPost.address == null
                      ? Text(AppLocalizations.of(context)!.notSpecified,
                          style: GoogleFonts.montserrat(
                              fontSize: 14, color: Colors.grey))
                      : Text(
                          jobPost.address!.location ?? '',
                          style: GoogleFonts.montserrat(fontSize: 14),
                        ),
                ],
              )),
          Expanded(flex: 2, child: Container()),
          Expanded(
              flex: 1,
              child: RoundedImageWidget(
                imageUrl: jobPost.companyLogo ?? '',
                size: 50,
                firstChar: getFirstChar(jobPost.companyName ?? ''),
              )),
        ])
      ],
    );
  }
}