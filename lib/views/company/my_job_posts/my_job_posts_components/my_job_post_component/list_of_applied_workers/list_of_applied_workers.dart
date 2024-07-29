import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../models/job_post.dart';
import '../../../../../../models/worker.dart';
import '../../../../../../providers/worker_provider.dart';
import '../../interesting_workers_components/loading_interesting_workers.dart';

class ListOfAppliedWorkers extends StatelessWidget {
  final JobPost jobPost;
  const ListOfAppliedWorkers({super.key, required this.jobPost});

  @override
  Widget build(BuildContext context) {
    WorkerProvider wp = Provider.of<WorkerProvider>(context);
    return wp.appliedWorkers.isEmpty
        ? const LoadingInterestingWorkers()
        : ListView.separated(
            itemCount: wp.appliedWorkers.length,
            itemBuilder: (BuildContext context, int index) {
              Worker worker = wp.appliedWorkers[index];
              return ListTile(
                title: Text(
                    '${worker.workerResumeDetails?.firstName} + ${worker.workerResumeDetails?.lastName}'),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(
                height: 5,
              );
            },
          );
  }
}
