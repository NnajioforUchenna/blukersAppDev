import 'package:blukers/views/worker/workers_path/desktop_worker_path.dart';
import 'package:blukers/views/worker/workers_path/moblie_worker_path.dart';
import 'package:flutter/material.dart';

class WorkerPath extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    if (width >= 600) {
      // If width is 600 or more, use DesktopLayout
      return DesktopWorkerPath();
  
    } else {
      // Otherwise, use MobileLayout
      return MoblieWorkerPath();
    }
  }
}
