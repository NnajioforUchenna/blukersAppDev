import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../providers/user_provider_parts/user_provider.dart';
import '../../../../worker/jobs_home/job_home_components/jobs_desktop_view/desktop_select_or_search_jobs.dart';
import '../../display_worker_by_preference.dart';

class WorkersPageDesktop extends StatelessWidget {
  const WorkersPageDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider up = Provider.of<UserProvider>(context);
    return up.isUserRegistered()
        ? const DisplayWorkersByPreference()
        : const DesktopSelectOrSearchJobs();
  }
}
