import 'package:blukers/providers/worker_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'display_worker_details.dart';

class AnimateWorkerDetails extends StatelessWidget {
  const AnimateWorkerDetails({super.key});

  @override
  Widget build(BuildContext context) {
    WorkerProvider wp = Provider.of<WorkerProvider>(context);
    return wp.selectedWorker == null
        ? const Center(child: CircularProgressIndicator())
        : WorkerDisplayDetailsWidget(
            worker: wp.selectedWorker!,
          );
  }
}
