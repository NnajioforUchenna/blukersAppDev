import 'package:bulkers/providers/job_posts_provider.dart';
import 'package:bulkers/providers/worker_provider.dart';
import 'package:bulkers/utils/helpers/index.dart';
import 'package:bulkers/utils/styles/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';

import '../../../models/job.dart';
import '../../../providers/user_provider.dart';
import '../../../services/on_hover.dart';
import '../../company/workers_components/display_workers.dart';
import '../../worker/jobs_componets/display_jobs.dart';
import '../applicant_count.dart';

class IndustryBodyPanel extends StatelessWidget {
  final List<Job> jobs;

  const IndustryBodyPanel({super.key, required this.jobs});

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
              jp.getJobPostsByJobID(job.jobId);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DisplayJobs(
                    title: job.title,
                  ),
                ),
              );
            }
          },
          child: OnHover(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  // side: const BorderSide(
                  //     color: ThemeColors.primaryThemeColor, width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    ListTile(
                      title: Row(
                        children: [
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                text: job.title,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: ThemeColors.primaryThemeColor,
                                ),
                              ),
                            ),
                          ),
                          // Spacer(),
                          Icon(
                            up.userRole == 'company'
                                ? UniconsLine.users_alt
                                : UniconsLine.briefcase_alt,
                            color: ThemeColors.primaryThemeColor,
                            size: 30.0,
                          ),
                          ApplicantCount(
                            count: up.userRole == 'company'
                                ? job.numberOfApplicants
                                : job.numberOfJobPosts,
                            color: ThemeColors.primaryThemeColor,
                          ),
                        ],
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 4.0, bottom: 6.0),
                        child: Text(
                          'Salary: ${NumberFormatHelper().doubleToStrSimpleCurrency(job.lowRange)} - ${NumberFormatHelper().doubleToStrSimpleCurrency(job.highRange)}',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: ThemeColors.grey1ThemeColor,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}