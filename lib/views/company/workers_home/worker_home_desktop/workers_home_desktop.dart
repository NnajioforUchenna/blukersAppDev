import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/user_provider_parts/user_provider.dart';
import '../worker_home_mobile/display_workers_by_preference.dart';
import 'desktop_select_and_search_workers.dart';

class WorkersHomeDesktop extends StatelessWidget {
  const WorkersHomeDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider up = Provider.of<UserProvider>(context);
    return up.isUserRegistered()
        ? const DisplayWorkersByPreference()
        : const DesktopSelectAndSearchWorkers();
  }
}
