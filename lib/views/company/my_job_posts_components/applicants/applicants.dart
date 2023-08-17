import 'package:blukers/providers/worker_provider.dart';
import 'package:blukers/views/company/workers_components/complete_worker_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
