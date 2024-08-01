import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/user_provider_parts/user_provider.dart';
import 'display_workers_by_preference.dart';
import 'select_or_search_workers.dart';

class WorkersHomeMobile extends StatelessWidget {
  const WorkersHomeMobile({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider up = Provider.of<UserProvider>(context);
    return !up.isUserRegistered()
        ? const DisplayWorkersByPreference()
        : const SelectOrSearchWorkers();
  }
}
