import 'package:bulkers/providers/job_posts_provider.dart';
import 'package:bulkers/providers/worker_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/job.dart';
import '../../providers/user_provider.dart';
import '../company/workers_components/display_workers.dart';
import '../worker/jobs_componets/display_jobs.dart';
import 'applicant_count.dart';

class IndustryBodyPanel extends StatelessWidget {
  final List<Job> jobs;

  const IndustryBodyPanel({super.key, required this.jobs});

  @override
  Widget build(BuildContext context) {
    WorkerProvider wp = Provider.of<WorkerProvider>(context);
    UserProvider up = Provider.of<UserProvider>(context);
    JobPostsProvider jp = Provider.of<JobPostsProvider>(context);
    return ListView.builder(
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
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: ListTile(
                title: Row(
                  children: [
                    Text(job.title),
                    ApplicantCount(
                        count: up.userRole == 'company'
                            ? job.numberOfApplicants
                            : job.numberOfJobPosts,
                        color: Colors.blueGrey)
                  ],
                ),
                trailing: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text('Salary: ${job.lowRange} - ${job.highRange}'),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
