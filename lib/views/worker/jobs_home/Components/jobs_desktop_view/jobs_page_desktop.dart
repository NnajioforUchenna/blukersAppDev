import 'package:blukers/views/worker/jobs_home/Components/display_jobs_by_preferences/display_jobs_by_preferences_desktop.dart';
import 'package:blukers/views/worker/select_job_industry/select_industry_desktop.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../providers/user_provider_parts/user_provider.dart';
class JobsPageDesktop extends StatelessWidget {
  const JobsPageDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider up = Provider.of<UserProvider>(context);
    return up.isUserRegistered()
        ? const DisplayJobsByPreferencesDesktop()
        : const SelectIndustryScreenDesktop();
  }
}
