import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../../models/industry.dart';
import '../../../../../services/on_hover.dart';
import '../../../../../services/responsive.dart';
import '../../../../../utils/localization/localized_industries.dart';
import '../../../../../utils/styles/theme_colors.dart';
import '../../../../models/job.dart';
import '../../../../providers/user_provider_parts/user_provider.dart';
import '../../../../providers/worker_provider.dart';
import '../../../../utils/localization/localized_job_ids.dart';
import '../../../company/workers_home/workers_components/display_workers.dart';

class IndustryWidget extends StatefulWidget {
  final Industry industry;
  final Function getRecords;
  const IndustryWidget(
      {super.key, required this.industry, required this.getRecords});

  @override
  State<IndustryWidget> createState() => _IndustryWidgetState();
}

class _IndustryWidgetState extends State<IndustryWidget> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          child: OnHover(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: const Color(0XFFE5E5E5),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    offset: const Offset(0, 5),
                    blurRadius: 10,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Row(
                children: [
                  widget.industry.imageUrlSvg != null
                      ? SvgPicture.asset(widget.industry.imageUrlSvg!,
                          colorFilter: ColorFilter.mode(
                              isExpanded
                                  ? ThemeColors.secondaryThemeColor
                                  : const Color.fromRGBO(117, 117, 117, 1),
                              BlendMode.srcIn),
                          width: Responsive.isDesktop(context) ? 40 : 28,
                          height: Responsive.isDesktop(context) ? 40 : 28,
                          fit: BoxFit.cover)
                      : Container(
                          width: Responsive.isDesktop(context) ? 40 : 28,
                          height: Responsive.isDesktop(context) ? 40 : 28,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit
                                  .cover, // This ensures the image covers the circular area
                              image: AssetImage(widget.industry.imageUrl!),
                            ),
                          ),
                        ),
                  SizedBox(width: Responsive.isDesktop(context) ? 25 : 10),
                  Expanded(
                      child: Text(
                    LocalizedIndustries.get(
                        context, widget.industry.industryId),
                    style: GoogleFonts.montserrat(
                      fontSize: Responsive.isDesktop(context) ? 25 : 16,
                      color: isExpanded
                          ? ThemeColors.secondaryThemeColor
                          : const Color.fromRGBO(117, 117, 117, 1),
                    ),
                  )),
                  AnimatedRotation(
                    turns: isExpanded ? 0.25 : 0.0,
                    duration: const Duration(milliseconds: 300),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: Responsive.isDesktop(context) ? 25 : null,
                      color: isExpanded
                          ? ThemeColors.secondaryThemeColor
                          : const Color.fromRGBO(117, 117, 117, 1),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        isExpanded
            ? Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  AppLocalizations.of(context)!.selectAJobPosition,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: ThemeColors.secondaryThemeColor,
                  ),
                ),
              )
            : Container(),
        isExpanded
            ? IndustryBodyPanel(
                jobs: widget.industry.jobs.values.toList(),
                getRecords: widget.getRecords,
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}

class IndustryBodyPanel extends StatelessWidget {
  final List<Job> jobs;
  final Function getRecords;
  const IndustryBodyPanel(
      {super.key, required this.jobs, required this.getRecords});

  @override
  Widget build(BuildContext context) {
    WorkersProvider wp = Provider.of<WorkersProvider>(context);
    UserProvider up = Provider.of<UserProvider>(context);
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: jobs.length,
      itemBuilder: (context, index) {
        final job = jobs[index];
        return InkWell(
          onTap: () {
            if (up.userRole == 'company') {
              wp.getWorkersByJobID(job.jobId);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DisplayWorkers(
                    title: job.title,
                  ),
                ),
              );
            } else {
              getRecords(context, job);
            }
          },
          child: Container(
              margin: const EdgeInsets.only(bottom: 5),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Expanded(
                      flex: 7,
                      child: Container(
                        margin: const EdgeInsets.all(15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                text: LocalizedJobIds.get(context, job.title),
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: ThemeColors.primaryThemeColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                  Expanded(
                      flex: 3,
                      child: Container(
                        margin: const EdgeInsets.only(right: 20),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.groups,
                              color: ThemeColors.primaryThemeColor,
                            ),
                            Icon(Icons.arrow_forward_ios, color: Colors.grey)
                          ],
                        ),
                      )),
                ],
              )),
        );
      },
    );
  }
}
