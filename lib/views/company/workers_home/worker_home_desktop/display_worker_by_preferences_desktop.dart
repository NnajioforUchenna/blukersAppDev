import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/user_provider_parts/user_provider.dart';
import 'set_worker_preferences_desktop.dart';
import 'show_workers_by_preferences_desktop.dart';

class DesktopDisplayWorkersByPreference extends StatelessWidget {
  const DesktopDisplayWorkersByPreference({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider up = Provider.of<UserProvider>(context);
    return up.isWorkerPreferencesSet()
        ? const DesktopShowWorkersByPreferences()
        : const DesktopSetWorkersPreferences();
  }
}
