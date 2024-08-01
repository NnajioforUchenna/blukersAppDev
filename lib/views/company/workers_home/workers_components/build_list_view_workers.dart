import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../models/worker.dart';
import '../../../../providers/worker_provider.dart';
import '../../../../services/responsive.dart';
import 'display_worker_card.dart';
import 'display_worker_dialog.dart';

class BuildListViewWorkers extends StatelessWidget {
  const BuildListViewWorkers({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    WorkersProvider wp = Provider.of<WorkersProvider>(context);
    final List<Worker> workers = wp.selectedWorkers;

    return ListView.separated(
      padding:
          const EdgeInsets.all(10), // Added to give some space around cards
      itemCount: workers.length,
      itemBuilder: (context, index) {
        final worker = workers[index];
        return DisplayWorkerCard(
            worker: worker,
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
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(
          height: 5,
        );
      },
    );
  }
}
