import 'package:bulkers/models/worker.dart';
import 'package:bulkers/providers/company_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/worker_provider.dart';
import '../workers_components/complete_worker_widget.dart';
import 'interesting_workers_components/loading_interesting_workers.dart';
import 'interesting_workers_components/no_interesting_worker.dart';

import 'package:bulkers/views/common_views/components/icon_text_404.dart';
import 'package:unicons/unicons.dart';

import 'package:bulkers/views/common_views/components/animations/index.dart';

class InterestingWorkersTab extends StatelessWidget {
  const InterestingWorkersTab({super.key});

  @override
  Widget build(BuildContext context) {
    CompanyProvider cp = Provider.of<CompanyProvider>(context);
    WorkerProvider wp = Provider.of<WorkerProvider>(context);
    return StreamBuilder<List<Worker>>(
      stream: cp.getInterestingWorkersStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // return const LoadingInterestingWorkers();
          return MyAnimation(name: 'circlePulseBlue2');
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          // return const NoInterestingWorkers();
          return IconText404(text: "No workers", icon: UniconsLine.constructor);
        } else {
          List<Worker> workers = snapshot.data!;
          return CompleteWorkerWidget(workers: workers);
        }
      },
    );
  }
}
