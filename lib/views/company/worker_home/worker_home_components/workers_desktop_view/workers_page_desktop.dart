import 'package:blukers/views/company/worker_home/worker_home_components/workers_desktop_view/workers_desktop_view_components/desktop_select_and_search_workers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../providers/user_provider_parts/user_provider.dart';
import '../../display_worker_by_preference.dart';

class WorkersPageDesktop extends StatelessWidget {
  const WorkersPageDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider up = Provider.of<UserProvider>(context);
    return up.isUserRegistered()
        ? const DisplayWorkersByPreference()
        : const DesktopSelectAndSearchWorkers();
  }
}
