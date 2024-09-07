import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../common_files/constants.dart';
import '../../../../models/job_post.dart';

class MobileDetailPageBlockFour extends StatelessWidget {
  final JobPost jobPost;
  const MobileDetailPageBlockFour({super.key, required this.jobPost});

  @override
  Widget build(BuildContext context) {
    double topPadding = MediaQuery.of(context).size.height * 0.05;
    return Container(
      margin: EdgeInsets.only(top: topPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppLocalizations.of(context)!.description,
              style: GoogleFonts.montserrat(
                  fontSize: 17, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          displayParagraph(jobPost.jobDescription ?? ''),
        ],
      ),
    );
  }
}
