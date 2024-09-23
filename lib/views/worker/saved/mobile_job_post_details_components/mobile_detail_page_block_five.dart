import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../common_files/constants.dart';
import '../../../../models/job_post.dart';

class MobileDetailPageBlockFive extends StatelessWidget {
  final JobPost jobPost;
  const MobileDetailPageBlockFive({super.key, required this.jobPost});

  @override
  Widget build(BuildContext context) {
    double topPadding = MediaQuery.of(context).size.height * 0.05;
    return Container(
      margin: EdgeInsets.only(top: topPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppLocalizations.of(context)!.requirements,
                    style: GoogleFonts.montserrat(
                        fontSize: 20,
                        fontWeight: FontWeight.w600)), // Responsive font size
                const SizedBox(height: 10), // Responsive height
                displayParagraph(jobPost.requirements, size: 12),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
