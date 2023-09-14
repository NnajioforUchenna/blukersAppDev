import 'package:blukers/models/job_post.dart';
import 'package:blukers/providers/worker_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../models/worker.dart';
import '../../interesting_workers_components/loading_interesting_workers.dart';

class ListOfAppliedWorkers extends StatelessWidget {
  final JobPost jobPost;
  const ListOfAppliedWorkers({super.key, required this.jobPost});

  @override
  Widget build(BuildContext context) {
    WorkerProvider wp = Provider.of<WorkerProvider>(context);
    return wp.appliedWorkers.isEmpty
        ? LoadingInterestingWorkers()
        : ListView.separated(
            itemCount: wp.appliedWorkers.length,
            itemBuilder: (BuildContext context, int index) {
              Worker worker = wp.appliedWorkers[index];
              return ListTile(
                title: Text('${worker.firstName} + ${worker.lastName}'),
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
