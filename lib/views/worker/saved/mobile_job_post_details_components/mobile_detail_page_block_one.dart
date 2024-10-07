import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../common_files/constants.dart';
import '../../../../models/job_post.dart';
import '../../../../utils/styles/theme_colors.dart';

class MobileDetailPageBlockOne extends StatelessWidget {
  final JobPost jobPost;
  const MobileDetailPageBlockOne({super.key, required this.jobPost});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: AutoSizeText(
                      toTitleCase(jobPost.jobTitle),
                      minFontSize: 18,
                      maxFontSize: 25,
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w600,
                        
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const CircleAvatar(
                      radius: 13,
                      backgroundColor: ThemeColors.secondaryThemeColorDark,
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 15,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset("assets/icons/company_icon.svg"),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Text(
                        "${jobPost.companyName}, ${jobPost.location ?? AppLocalizations.of(context)!.notSpecified}",
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: ThemeColors.black1ThemeColor,
                        )),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Row(
                    children: [
                      SvgPicture.asset("assets/icons/cash_icon.svg"),
                      const SizedBox(width: 5),
                      Text(
                        '\$ ${jobPost.salaryAmount}  ${getSalaryType(jobPost.salaryType)}',
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: ThemeColors.black1ThemeColor),
                      ),
                    ],
                  ),
                  const SizedBox(width: 20),
                  Row(
                    children: [
                      SvgPicture.asset("assets/icons/time_icon.svg"),
                      const SizedBox(width: 5),
                      Text(
                        getJobType(jobPost.jobType),
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: ThemeColors.black1ThemeColor),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }
}
