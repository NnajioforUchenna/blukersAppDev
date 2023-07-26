import 'package:flutter/material.dart';

import '../../../models/job.dart';

class IndustryBodyPanel extends StatelessWidget {
  final List<Job> jobs;
  const IndustryBodyPanel({super.key, required this.jobs});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: jobs.length,
      itemBuilder: (context, index) {
        final job = jobs[index];
        return InkWell(
          onTap: () {
            print('Get all Workers for this job: ${job.jobId}'); // New line.
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: ListTile(
                title: Text(job.title),
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
