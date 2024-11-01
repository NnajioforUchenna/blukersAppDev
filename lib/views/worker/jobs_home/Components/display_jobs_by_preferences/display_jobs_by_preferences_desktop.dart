import 'package:blukers/providers/user_provider_parts/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Components/set_jobs_preferences_desktop.dart';
import 'Components/show_jobs_by_preferences_desktop.dart';

class DisplayJobsByPreferencesDesktop extends StatelessWidget {
  const DisplayJobsByPreferencesDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider up = Provider.of<UserProvider>(context);
    return up.isJobsPreferencesSet()
        ? const ShowJobsByPreferencesDesktop()
        : const SetJobsPreferencesDesktop();
  }
}
