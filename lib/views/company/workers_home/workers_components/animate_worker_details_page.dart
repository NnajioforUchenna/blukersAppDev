import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/worker_provider.dart';
import 'display_worker_details.dart';

class AnimateWorkerDetails extends StatelessWidget {
  const AnimateWorkerDetails({super.key});

  @override
  Widget build(BuildContext context) {
    WorkersProvider wp = Provider.of<WorkersProvider>(context);
    return wp.selectedWorker == null
        ? const Center(child: CircularProgressIndicator())
        : WorkerDisplayDetailsWidget(
            worker: wp.selectedWorker!,
          );
  }
}
