import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../models/job_post.dart';
import '../../../../providers/worker_provider.dart';
import '../../../old_common_views/applicant_count.dart';

class DetailPageBlockFive extends StatefulWidget {
  final JobPost jobPost;
  const DetailPageBlockFive({super.key, required this.jobPost});

  @override
  State<DetailPageBlockFive> createState() => _DetailPageBlockFiveState();
}

class _DetailPageBlockFiveState extends State<DetailPageBlockFive> {
  bool isGetApplicant = false;

  @override
  Widget build(BuildContext context) {
    WorkersProvider wp = Provider.of<WorkersProvider>(context);
    return widget.jobPost.applicantUserIds.isEmpty
        ? Container()
        : Padding(
            padding: const EdgeInsets.all(16.0), // Add padding around the edges
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Align content to start
                children: [
                  Text(AppLocalizations.of(context)!.applicants,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                  InkWell(
                    onTap: () async {
                      setState(() {
                        isGetApplicant = !isGetApplicant;
                      });
                      bool result = await wp
                          .getApplicants(widget.jobPost.applicantUserIds);
                      setState(() {
                        isGetApplicant = !isGetApplicant;
                      });
                      if (result) {
                        context.go('/applicants');
                      }
                    },
                    child: Row(
                      children: [
                        Text(AppLocalizations.of(context)!.newApplicants,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 15),
                        if (widget.jobPost.applicantUserIds.isNotEmpty)
                          ApplicantCount(
                              count: widget.jobPost.applicantUserIds.length,
                              color: Colors.green),
                      ],
                    ),
                  ),
                  SizedBox(height: 15.h),
                  const Divider(),
                ],
              ),
            ),
          );
  }
}
