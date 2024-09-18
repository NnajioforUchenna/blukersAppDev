import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../models/job_post.dart';

class MobileDetailPageBlockTwo extends StatelessWidget {
  final JobPost jobPost;
  const MobileDetailPageBlockTwo({super.key, required this.jobPost});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
             padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Job Information",
                    style: GoogleFonts.montserrat(
                        fontSize: 16, fontWeight: FontWeight.w600)),
                const SizedBox(height: 10),
                Row(
                  children: [
                    SvgPicture.asset("assets/icons/industry_ic.svg"),
                    const SizedBox(width: 5),
                    RichText(
                      text: TextSpan(
                        style: GoogleFonts.montserrat(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                        children: [
                          TextSpan(
                              text: "${AppLocalizations.of(context)!.industry}: ",
                              style: GoogleFonts.montserrat(
                                color: const Color.fromRGBO(51, 51, 51, 0.7),
                              )),
                          TextSpan(
                            text: jobPost.industryIds.isNotEmpty
                                ? jobPost.industryIds.join(', ')
                                : AppLocalizations.of(context)!.notSpecified,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    SvgPicture.asset("assets/icons/industry_ic.svg"),
                    const SizedBox(width: 5),
                    RichText(
                      text: TextSpan(
                        style: GoogleFonts.montserrat(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                        children: [
                          TextSpan(
                              text: "${AppLocalizations.of(context)!.jobPosition}: ",
                              style: GoogleFonts.montserrat(
                                color: const Color.fromRGBO(51, 51, 51, 0.7),
                              )),
                          TextSpan(
                            text: jobPost.jobIds.isNotEmpty
                                ? jobPost.jobIds.join(', ')
                                : AppLocalizations.of(context)!.notSpecified,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    SvgPicture.asset("assets/icons/industry_ic.svg"),
                    const SizedBox(width: 5),
                    RichText(
                      text: TextSpan(
                        style: GoogleFonts.montserrat(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                        children: [
                          TextSpan(
                              text: "${AppLocalizations.of(context)!.skills}: ",
                              style: GoogleFonts.montserrat(
                                color: const Color.fromRGBO(51, 51, 51, 0.7),
                              )),
                          TextSpan(
                            text: jobPost.skills.isNotEmpty
                                ? jobPost.skills.join(', ')
                                : AppLocalizations.of(context)!.notSpecified,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
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
