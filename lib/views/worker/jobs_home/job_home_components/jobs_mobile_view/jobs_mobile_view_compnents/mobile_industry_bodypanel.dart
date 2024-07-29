import 'package:blukers/utils/localization/localized_job_ids.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../models/job.dart';
import '../../../../../../providers/job_posts_provider.dart';
import '../../../../../../providers/user_provider_parts/user_provider.dart';
import '../../../../../../providers/worker_provider.dart';
import '../../../../../../utils/styles/theme_colors.dart';
import '../../../../../company/workers_home/workers_components/display_workers.dart';
import '../../../../saved/display_jobs.dart';

class MobileIndustryBodyPanel extends StatelessWidget {
  final List<Job> jobs;

  const MobileIndustryBodyPanel({super.key, required this.jobs});

  @override
  Widget build(BuildContext context) {
    WorkersProvider wp = Provider.of<WorkersProvider>(context);
    UserProvider up = Provider.of<UserProvider>(context);
    JobPostsProvider jp = Provider.of<JobPostsProvider>(context);
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
              // navigate anonymously to the DisplayWorkers page
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DisplayWorkers(
                    title: job.title,
                  ),
                ),
              );
            } else {
              // navigate anonymously to the DisplayWorkers page
              jp.getJobPostsByJobID(job.title, up.userLanguage);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DisplayJobs(
                    title: job.title,
                  ),
                ),
              );
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
