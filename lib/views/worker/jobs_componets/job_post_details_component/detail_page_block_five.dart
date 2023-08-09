import 'package:bulkers/providers/worker_provider.dart';
import 'package:bulkers/views/common_views/applicant_count.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../models/job_post.dart';

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
    WorkerProvider wp = Provider.of<WorkerProvider>(context);
    return widget.jobPost.applicantUserIds!.isEmpty
        ? Container()
        : Padding(
            padding: EdgeInsets.all(16.0), // Add padding around the edges
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Align content to start
                children: [
                  const Text("Applicants",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  InkWell(
                    onTap: () async {
                      setState(() {
                        isGetApplicant = !isGetApplicant;
                      });
                      bool result = await wp
                          .getApplicants(widget.jobPost.applicantUserIds!);
                      setState(() {
                        isGetApplicant = !isGetApplicant;
                      });
                      if (result) {
                        Navigator.pushNamed(context, '/applicants');
                      }
                      ;
                    },
                    child: Row(
                      children: [
                        const Text("New Applicants",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        SizedBox(height: 15),
                        if (widget.jobPost.applicantUserIds!.isNotEmpty)
                          ApplicantCount(
                              count: widget.jobPost.applicantUserIds!.length,
                              color: Colors.green),
                      ],
                    ),
                  ),
                  Divider(),
                ],
              ),
            ),
          );
  }
}
