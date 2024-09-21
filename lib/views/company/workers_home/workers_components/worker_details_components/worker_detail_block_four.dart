import 'package:blukers/utils/helpers/index.dart';
import 'package:blukers/utils/styles/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../models/work_experience.dart';
import '../../../../../services/responsive.dart';

class WorkerDetailBlockFour extends StatefulWidget {
  final List<WorkExperience> workExperiences;

  const WorkerDetailBlockFour({super.key, required this.workExperiences});

  @override
  State<WorkerDetailBlockFour> createState() => _WorkerDetailBlockFourState();
}

class _WorkerDetailBlockFourState extends State<WorkerDetailBlockFour> {
  final int index = 0;
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding:EdgeInsets.only(top: Responsive.isMobile(context) ? 16 : 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Work Experience",
                style: GoogleFonts.montserrat(
                    fontSize: Responsive.isMobile(context) ? 14 : 20, fontWeight: FontWeight.w600),
              ),
              if (widget.workExperiences.isNotEmpty)
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        if (index > 0) {
                          setState(() {
                            index - 1;
                          });
                        }
                      },
                      child: const Icon(
                        Icons.arrow_back_ios,
                        size: 15,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    RichText(
                        text: TextSpan(
                            text: "${index + 1}",
                            style: const TextStyle(
                                color: ThemeColors.secondaryThemeColorDark,
                                fontSize: 11),
                            children: [
                          TextSpan(
                            text: " of ${widget.workExperiences.length}",
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 11),
                          )
                        ])),
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {
                        if (index < widget.workExperiences.length - 1) {
                          setState(() {
                            index + 1;
                          });
                        }
                      },
                      child: const Icon(
                        size: 15,
                        Icons.arrow_forward_ios,
                      ),
                    ),
                  ],
                )
            ],
          ),
          if (widget.workExperiences.isNotEmpty) const SizedBox(height: 10),
          if (widget.workExperiences.isNotEmpty)
           SizedBox(
              height: Responsive.isMobile(context)? 115: 125,
              child: PageView.builder(
                itemCount: widget.workExperiences.length,
                physics: const NeverScrollableScrollPhysics(),
                controller: PageController(initialPage: index),
                itemBuilder: (context, index) => SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                         SvgPicture.asset(
                            "assets/icons/company_icon.svg",
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "Company: ",
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w500,
                                color: Colors.black.withOpacity(0.5),
                                fontSize:
                                    Responsive.isMobile(context) ? 12 : 16),
                          ),
                          Expanded(
                            child: Text(
                              widget.workExperiences[index].companyName.isEmpty? "--": widget.workExperiences[index].companyName,
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w500,
                                fontSize:
                                    Responsive.isMobile(context) ? 12 : 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                      
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on_outlined,
                              size: 20,
                              color: ThemeColors.secondaryThemeColorDark,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              "Location: ",
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black.withOpacity(0.5),
                                  fontSize:
                                      Responsive.isMobile(context) ? 12 : 16),
                            ),
                            Expanded(
                              child: Text(
                              widget.workExperiences[index].location == null ? "--":  "${widget.workExperiences[index].location!.city}, ${widget.workExperiences[index].location!.country}",
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w500,
                                  fontSize:
                                      Responsive.isMobile(context) ? 12 : 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      Row(
                        children: [
                         SvgPicture.asset(
                            "assets/icons/box_icon.svg",
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "Job title: ",
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w500,
                                color: Colors.black.withOpacity(0.5),
                                fontSize:
                                    Responsive.isMobile(context) ? 12 : 16),
                          ),
                          Expanded(
                            child: Text(
                              widget.workExperiences[index].jobTitle.isEmpty ? "--": widget.workExperiences[index].jobTitle,
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w500,
                                fontSize:
                                    Responsive.isMobile(context) ? 12 : 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                         SvgPicture.asset(
                            "assets/icons/doc_icon.svg",
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "Description: ",
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w500,
                                color: Colors.black.withOpacity(0.5),
                                fontSize:
                                    Responsive.isMobile(context) ? 12 : 16),
                          ),
                          Expanded(
                            child: Text(
                              widget.workExperiences[index].jobDescription.isEmpty ? "--": widget.workExperiences[index].jobDescription,
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w500,
                                fontSize:
                                    Responsive.isMobile(context) ? 12: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(
                            "assets/icons/date_icon.svg",
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "Date: ",
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w500,
                                color: Colors.black.withOpacity(0.5),
                                fontSize:
                                    Responsive.isMobile(context) ? 12 : 16),
                          ),
                          Expanded(
                            child: Text(
                              "${widget.workExperiences[index].jobStartDate == null ? "--" : DateFormatHelper.formatMonthYear(widget.workExperiences[index].jobStartDate!)} ${widget.workExperiences[index].isCurrentlyWorking ? "" : " to ${widget.workExperiences[index].jobEndDate == null ? "--" : DateFormatHelper.formatMonthYear(widget.workExperiences[index].jobEndDate!)}"}",
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w500,
                                fontSize:
                                    Responsive.isMobile(context) ? 12 : 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          SizedBox(height: Responsive.isMobile(context) ? 16 : 20),
          const Divider(
             color: Color.fromRGBO(0, 0, 0, 0.2),
          ),
        ],
      ),
    );
  }
}
