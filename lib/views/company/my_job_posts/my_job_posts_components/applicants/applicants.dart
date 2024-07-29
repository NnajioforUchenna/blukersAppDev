import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../providers/worker_provider.dart';
import '../../../workers_home/workers_components/complete_worker_widget.dart';

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
