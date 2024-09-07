import 'package:blukers/views/worker/select_job_industry/select_industry_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../providers/user_provider_parts/user_provider.dart';
import '../display_jobs_by_preferences/display_jobs_by_preferences.dart';
import 'select_or_search_jobs.dart';

class JobsPageMobile extends StatelessWidget {
  const JobsPageMobile({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider up = Provider.of<UserProvider>(context);
    return up.isUserRegistered()
        ? const DisplayJobsByPreferences()
        : const SelectIndustryScreen();
  }
}
