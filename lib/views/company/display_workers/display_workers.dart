import 'package:blukers/providers/worker_provider.dart';
import 'package:blukers/views/common_vieiws/loading_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/worker.dart';
import '../../../services/responsive.dart';
import '../workers_home/workers_components/display_worker_card.dart';
import '../workers_home/workers_components/display_worker_dialog.dart';

class DisplayWorkers extends StatelessWidget {
  const DisplayWorkers({super.key});

  @override
  Widget build(BuildContext context) {
    WorkersProvider wp = Provider.of<WorkersProvider>(context);
    if (wp.workersToDisplay.isEmpty) {
      return const LoadingPage();
    }
    return ListView.builder(
      itemCount: wp.workersToDisplay.length,
      itemBuilder: (context, index) {
        Worker worker = wp.workersToDisplay[index];
        return DisplayWorkerCard(
            worker: wp.workersToDisplay[index],
            onTap: () {
              if (Responsive.isDesktop(context)) {
                wp.setSelectedWorker(worker);
              } else {
                wp.setSelectedWorker(worker); // Add this line
                showDialog(
                    context: context,
                    builder: (context) => DisplayWorkerDialog(
                          worker: worker,
                        ));
              }
            });
      },
    );
  }
}
