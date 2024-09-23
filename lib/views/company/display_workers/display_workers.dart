import 'package:blukers/providers/worker_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/worker.dart';
import '../../../services/responsive.dart';
import '../workers_home/workers_components/animate_worker_details_page.dart';
import '../workers_home/workers_components/display_worker_card.dart';
import '../workers_home/workers_components/display_worker_dialog.dart';

class DisplayWorkers extends StatelessWidget {
  const DisplayWorkers({super.key});

  @override
  Widget build(BuildContext context) {
    return const ListViewDisplayWorkers();
  }
}

class DisplayWorkersDesktop extends StatelessWidget {
  const DisplayWorkersDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .85,
      padding: EdgeInsets.only(top: 24),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1st column
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: ListViewDisplayWorkers(),
            ),
          ),
          // 2nd column
          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: AnimateWorkerDetails(),
            ),
          ),
        ],
      ),
    );
  }
}

class ListViewDisplayWorkers extends StatelessWidget {
  const ListViewDisplayWorkers({super.key});

  @override
  Widget build(BuildContext context) {
    WorkersProvider wp = Provider.of<WorkersProvider>(context);

    return ListView.separated(
      itemCount: wp.workersToDisplay.length,
      separatorBuilder: (context, index) {
        return const SizedBox(
          height: 20,
        );
      },
      padding: Responsive.isMobile(context)? EdgeInsets.symmetric(horizontal: 16, vertical:14 ): null,
      itemBuilder: (context, index) {
        Worker worker = wp.workersToDisplay[index];
        return DisplayWorkerCard(
            worker: worker,
            onTap: () {
              wp.setSelectedWorker(worker);
              if (!Responsive.isDesktop(context)) {
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
