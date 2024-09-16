import 'package:blukers/views/worker/select_job_industry/select_industry_desktop.dart';
import 'package:blukers/views/worker/select_job_industry/select_industry_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/user_provider_parts/user_provider.dart';
import 'desktop_select_and_search_workers.dart';
import 'display_worker_by_preferences_desktop.dart';

class WorkersHomeDesktop extends StatelessWidget {
  const WorkersHomeDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider up = Provider.of<UserProvider>(context);
    return up.isUserRegistered()
        ? const DesktopDisplayWorkersByPreference()
        : const SelectIndustryScreenDesktop();
  }
}

//  DesktopSelectAndSearchWorkers()