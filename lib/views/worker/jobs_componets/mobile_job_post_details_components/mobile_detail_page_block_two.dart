import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unicons/unicons.dart';

import '../../../../models/job_post.dart';
import '../../../common_views/components/shaped_icon.dart';

class MobileDetailPageBlockTwo extends StatelessWidget {
  final JobPost jobPost;
  const MobileDetailPageBlockTwo({super.key, required this.jobPost});

  @override
  Widget build(BuildContext context) {
    double topPadding = MediaQuery.of(context).size.height * 0.05;
    return Container(
      margin: EdgeInsets.only(top: topPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(AppLocalizations.of(context)!.aboutTheJob,
              textAlign: TextAlign.left,
              style: GoogleFonts.montserrat(
                  fontSize: 17, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          Row(
            children: [
              const ShapedIcon(icon: UniconsLine.hard_hat),
              const SizedBox(width: 10),
              RichText(
                text: TextSpan(
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                  ), // Default style
                  children: [
                    TextSpan(
                        text: "${AppLocalizations.of(context)!.industry}: ",
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color.fromARGB(255, 62, 62, 62),
                          fontFamily: 'Montserrat',
                        )),
                    TextSpan(
                        text: jobPost.industryIds.isNotEmpty
                            ? jobPost.industryIds.join(', ')
                            : AppLocalizations.of(context)!.notSpecified,
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
          const SizedBox(height: 5),
          Row(
            children: [
              const ShapedIcon(icon: UniconsLine.constructor),
              const SizedBox(width: 10),
              RichText(
                text: TextSpan(
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                  ), // Default style
                  children: [
                    TextSpan(
                        text: "${AppLocalizations.of(context)!.jobPosition}: ",
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color.fromARGB(255, 62, 62, 62),
                          fontFamily: 'Montserrat',
                        )),
                    TextSpan(
                        text: jobPost.jobIds.isNotEmpty
                            ? jobPost.jobIds.join(', ')
                            : AppLocalizations.of(context)!.notSpecified,
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
          const SizedBox(height: 5),
          Row(
            children: [
              const ShapedIcon(icon: UniconsLine.jackhammer),
              const SizedBox(width: 10),
              RichText(
                text: TextSpan(
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                  ), // Default style
                  children: [
                    TextSpan(
                        text: "${AppLocalizations.of(context)!.skills}: ",
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color.fromARGB(255, 62, 62, 62),
                          fontFamily: 'Montserrat',
                        )),
                    TextSpan(
                        text: jobPost.skills.isNotEmpty
                            ? jobPost.skills.join(', ')
                            : AppLocalizations.of(context)!.notSpecified,
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
        ],
      ),
    );
  }
}
