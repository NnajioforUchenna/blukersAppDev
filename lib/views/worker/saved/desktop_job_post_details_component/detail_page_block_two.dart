import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../models/job_post.dart';
import '../../../../providers/industry_provider.dart';

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
          Text("Job Information",
                  style: GoogleFonts.montserrat(
                      fontSize: 20, fontWeight: FontWeight.w600)),
          const SizedBox(height: 10),
          Row(
            children: [
              SvgPicture.asset("assets/icons/industry_ic.svg"),
              SizedBox(width: 1.h),
              RichText(
                text: TextSpan(
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
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
          SizedBox(height: 15.h),
          Row(
            children: [
              SvgPicture.asset("assets/icons/industry_ic.svg"),
              SizedBox(width: 1.h),
              RichText(
                text: TextSpan(
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
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
          SizedBox(height: 15.h),
          Row(
            children: [
              SvgPicture.asset("assets/icons/industry_ic.svg"),
              SizedBox(width: 1.h),
              RichText(
                text: TextSpan(
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
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
          SizedBox(height: 15.h),
        ],
      ),
    );
  }
}
