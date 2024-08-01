import 'package:blukers/services/responsive.dart';
import 'package:flutter/material.dart';

import 'desktop_worker_path.dart';
import 'moblie_worker_path.dart';

class WorkerPath extends StatelessWidget {
  const WorkerPath({super.key});

  @override
  Widget build(BuildContext context) {
    return Responsive.isMobile(context)
        ? const DesktopWorkerPath()
        : const MoblieWorkerPath();
  }
}
