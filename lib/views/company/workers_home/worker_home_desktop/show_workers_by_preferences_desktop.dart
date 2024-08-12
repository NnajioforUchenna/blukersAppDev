import 'package:blukers/views/company/workers_home/worker_home_desktop/workers_preferences_card_desktop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../display_workers/display_workers.dart';

class DesktopShowWorkersByPreferences extends StatelessWidget {
  const DesktopShowWorkersByPreferences({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 80.sp),
          child: const WorkersPreferencesCardDesktop(),
        ),
        const Expanded(child: DisplayWorkersDesktop()),
      ],
    );
  }
}
