import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../models/worker.dart';
import '../../../../providers/worker_provider.dart';
import 'components/complete_worker_widget.dart';

class WorkerSearchResultPage extends StatelessWidget {
  const WorkerSearchResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    WorkerProvider wp = Provider.of<WorkerProvider>(context);
    List<Worker> workers = wp.selectedWorkers;
    return CompleteWorkerWidget(workers: workers);
  }
}
