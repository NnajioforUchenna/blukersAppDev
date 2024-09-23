import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../common_files/constants.dart';
import '../../../../models/job_post.dart';

class MobileDetailPageBlockFour extends StatelessWidget {
  final JobPost jobPost;
  const MobileDetailPageBlockFour({super.key, required this.jobPost});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Job Description",
                    style: GoogleFonts.montserrat(
                        fontSize: 16, fontWeight: FontWeight.w600)),
                const SizedBox(height: 10),
                displayParagraph(jobPost.jobDescription, size: 12),
                const SizedBox(height: 16),
              ],
            ),
          ),
          const Divider()
        ],
      ),
    );
  }
}
