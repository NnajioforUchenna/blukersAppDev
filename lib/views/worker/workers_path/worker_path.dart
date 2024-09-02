import 'package:blukers/services/responsive.dart';
import 'package:blukers/views/worker/workers_path/desktop_worker_path.dart';
import 'package:blukers/views/worker/workers_path/moblie_worker_path.dart';
import 'package:flutter/material.dart';

class WorkerPath extends StatelessWidget {
  const WorkerPath({super.key});

  @override
  Widget build(BuildContext context) {
    return const Responsive(
      mobile: MoblieWorkerPath(),
      desktop: DesktopWorkerPath(),
    );
  }
}
