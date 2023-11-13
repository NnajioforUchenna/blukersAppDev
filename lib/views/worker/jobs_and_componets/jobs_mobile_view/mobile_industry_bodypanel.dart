import 'package:blukers/providers/job_posts_provider.dart';
import 'package:blukers/providers/worker_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../models/job.dart';
import '../../../../providers/user_provider_parts/user_provider.dart';
import '../../../../utils/helpers/number_format.dart';
import '../../../../utils/localization/localized_jobs.dart';
import '../../../../utils/styles/theme_colors.dart';
import '../../../company/workers_components/display_workers.dart';
import '../display_jobs.dart';

class MobileIndustryBodyPanel extends StatelessWidget {
  final List<Job> jobs;
  const MobileIndustryBodyPanel({super.key, required this.jobs});

  @override
  Widget build(BuildContext context) {
    WorkerProvider wp = Provider.of<WorkerProvider>(context);
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
                                text: LocalizedJobs.get(context, job.jobId),
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: ThemeColors.primaryThemeColor,
                                ),
                              ),
                            ),
                            Text(
                              '${AppLocalizations.of(context)!.salary}: ${NumberFormatHelper().doubleToStrSimpleCurrency(job.lowRange)} - ${NumberFormatHelper().doubleToStrSimpleCurrency(job.highRange)}',
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: ThemeColors.grey1ThemeColor,
                              ),
                            ),
                          ],
                        ),
                      )),
                  Expanded(
                      flex: 3,
                      child: Container(
                        child: Row(
                          children: [
                            const Icon(
                              Icons.groups,
                              color: ThemeColors.primaryThemeColor,
                            ),
                            Container(
                                height: 30,
                                width: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: ThemeColors.primaryThemeColor,
                                ),
                                margin: const EdgeInsets.only(
                                    left: 5, right: 5, top: 10, bottom: 10),
                                child: Center(
                                  child: Text(
                                    up.userRole == 'company'
                                        ? job.numberOfApplicants.toString()
                                        : job.numberOfJobPosts.toString(),
                                    style: GoogleFonts.montserrat(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                )),
                            const Icon(Icons.arrow_forward_ios,
                                color: Colors.grey)
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
