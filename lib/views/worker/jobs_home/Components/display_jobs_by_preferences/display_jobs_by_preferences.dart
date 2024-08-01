import 'package:blukers/providers/user_provider_parts/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Components/set_jobs_preferences.dart';
import 'Components/show_jobs_by_preferences.dart';

class DisplayJobsByPreferences extends StatelessWidget {
  const DisplayJobsByPreferences({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider up = Provider.of<UserProvider>(context);
    return up.isJobsPreferencesSet()
        ? const ShowJobsByPreferences()
        : const SetJobsPreferences();
  }
}
