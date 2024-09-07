import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unicons/unicons.dart';

import '../../../../common_files/constants.dart';
import '../../../../models/job_post.dart';

import '../../../old_common_views/components/shaped_icon.dart';

class MobileDetailPageBlockThree extends StatelessWidget {
  final JobPost jobPost;
  const MobileDetailPageBlockThree({super.key, required this.jobPost});

  @override
  Widget build(BuildContext context) {
    double topPadding = MediaQuery.of(context).size.height * 0.05;
    return Container(
      margin: EdgeInsets.only(top: topPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppLocalizations.of(context)!.details,
              style: GoogleFonts.montserrat(
                  fontSize: 17, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          Row(
            children: [
              const ShapedIcon(icon: UniconsLine.clock),
              const SizedBox(width: 10),
              RichText(
                text: TextSpan(
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                  ),
                  children: [
                    TextSpan(
                        text: "${AppLocalizations.of(context)!.schedule}: ",
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color.fromARGB(255, 62, 62, 62),
                          fontFamily: 'Montserrat',
                        )),
                    TextSpan(
                        text: jobPost.schedule,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                          fontFamily: 'Montserrat',
                        )),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 5), // Responsive height
          Row(
            children: [
              const ShapedIcon(icon: UniconsLine.calender),
              const SizedBox(width: 10),
              RichText(
                text: TextSpan(
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                  ),
                  children: [
                    TextSpan(
                        text: "${AppLocalizations.of(context)!.jobType}: ",
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color.fromARGB(255, 62, 62, 62),
                          fontFamily: 'Montserrat',
                        )),
                    TextSpan(
                        text: getJobType(jobPost.jobType),
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                          fontFamily: 'Montserrat',
                        )),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 5), // Responsive height
          Row(
            children: [
              const ShapedIcon(icon: UniconsLine.money_bill),
              const SizedBox(width: 10),
              RichText(
                text: TextSpan(
                  style: const TextStyle(
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
        ],
      ),
    );
  }
}
