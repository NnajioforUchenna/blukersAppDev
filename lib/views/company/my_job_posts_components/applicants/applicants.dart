import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/worker_provider.dart';
import '../../search_workers/workers_search_result_page/components/complete_worker_widget.dart';

class Applicants extends StatelessWidget {
  const Applicants({super.key});

  @override
  Widget build(BuildContext context) {
    WorkerProvider wp = Provider.of<WorkerProvider>(context);
    return wp.applicants.isEmpty
        ? Container()
        : Scaffold(
            appBar: AppBar(
              title: const Text('Applicants'),
            ),
            body: CompleteWorkerWidget(
              workers: wp.applicants,
            ));
  }
}
