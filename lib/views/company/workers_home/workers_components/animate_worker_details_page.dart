import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/worker_provider.dart';
import '../../../old_common_views/components/animations/index.dart';
import 'display_worker_details.dart';

class AnimateWorkerDetails extends StatelessWidget {
  const AnimateWorkerDetails({super.key});

  @override
  Widget build(BuildContext context) {
    WorkersProvider wp = Provider.of<WorkersProvider>(context);

    if (wp.selectedWorker != null) {
      return WorkerDisplayDetailsWidget(
        worker: wp.selectedWorker!,
      );
    } else if (wp.workersToDisplay.isNotEmpty) {
      return WorkerDisplayDetailsWidget(
        worker: wp.workersToDisplay.first,
      );
    } else {
      return const Center(
          child: MyAnimation(
        name: 'blukersLoadingDots',
      ));
    }
  }
}
