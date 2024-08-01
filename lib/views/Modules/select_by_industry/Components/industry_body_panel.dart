import 'package:flutter/material.dart';

import '../../../../models/job.dart';
import '../../../../utils/localization/localized_job_ids.dart';
import '../../../../utils/styles/theme_colors.dart';

class IndustryBodyPanel extends StatelessWidget {
  final List<Job> jobs;
  final Function getRecords;
  const IndustryBodyPanel(
      {super.key, required this.jobs, required this.getRecords});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: jobs.length,
      itemBuilder: (context, index) {
        final job = jobs[index];
        return InkWell(
          onTap: () {
            getRecords(context, job);
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
