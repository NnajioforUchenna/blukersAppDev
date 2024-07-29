import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../providers/user_provider_parts/user_provider.dart';
import '../../Components/display_jobs_by_preferences/display_jobs_by_preferences.dart';
import 'jobs_desktop_view_components/desktop_select_or_search_jobs.dart';

class JobsPageDesktop extends StatelessWidget {
  const JobsPageDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider up = Provider.of<UserProvider>(context);
    return up.isUserRegistered()
        ? const DisplayJobsByPreferences()
        : const DesktopSelectOrSearchJobs();
  }
}
