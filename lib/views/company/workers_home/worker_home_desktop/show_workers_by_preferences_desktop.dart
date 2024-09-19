import 'package:blukers/views/company/workers_home/worker_home_desktop/workers_preferences_card_desktop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../display_workers/display_workers.dart';

class DesktopShowWorkersByPreferences extends StatefulWidget {
  const DesktopShowWorkersByPreferences({super.key});

  @override
  State<DesktopShowWorkersByPreferences> createState() => _DesktopShowWorkersByPreferencesState();
}

class _DesktopShowWorkersByPreferencesState extends State<DesktopShowWorkersByPreferences> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        WorkersPreferencesCardDesktop(),
        Expanded(child: DisplayWorkersDesktop()),
      ],
    );
  }
}
