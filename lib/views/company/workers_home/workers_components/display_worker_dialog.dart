import 'package:flutter/material.dart';

import '../../../../models/worker.dart';
import 'animate_worker_details_page.dart';

class DisplayWorkerDialog extends StatelessWidget {
  final Worker worker;

  const DisplayWorkerDialog({super.key, required this.worker});

  @override
  Widget build(BuildContext context) {
    return const Dialog(
   backgroundColor: Colors.transparent,
      child: AnimateWorkerDetails(),
    );
  }
}
