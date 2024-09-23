import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../models/worker.dart';
import '../../../../providers/worker_provider.dart';
import '../../../../services/responsive.dart';
import 'animate_worker_details_page.dart';
import 'display_worker_card.dart';
import 'display_worker_dialog.dart';

class CompleteWorkerWidget extends StatelessWidget {
  final List<Worker> workers;

  const CompleteWorkerWidget({super.key, required this.workers});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints:
            BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.8),
        child: Responsive.isDesktop(context)
            ? buildWebContentWorkers(workers, context)
            : ListViewWorkers(
                workers: workers,
              ));
  }
}

buildWebContentWorkers(List<Worker> workers, context) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // 1st column
      Expanded(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListViewWorkers(
            workers: workers,
          ),
        ),
      ),
      // 2nd column
      const Expanded(
        flex: 2,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: AnimateWorkerDetails(),
        ),
      ),
    ],
  );
}

class ListViewWorkers extends StatelessWidget {
  final List<Worker> workers;

  const ListViewWorkers({super.key, required this.workers});

  @override
  Widget build(BuildContext context) {
    WorkersProvider wp = Provider.of<WorkersProvider>(context);
    return ListView.separated(
      padding:
          const EdgeInsets.all(10), // Added to give some space around cards
      itemCount: workers.length,
      itemBuilder: (context, index) {
        final worker = workers[index];
        return DisplayWorkerCard(
            worker: worker,
            onTap: () {
                wp.setSelectedWorker(worker);
              if (Responsive.isMobile(context)) {
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
                    height: 20,
        );
      },
    );
  }
}
