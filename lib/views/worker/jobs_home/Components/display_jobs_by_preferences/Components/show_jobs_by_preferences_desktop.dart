import 'package:flutter/material.dart';

import '../build_list_view_jobs_by_preferences_desktop.dart';
import 'jobs_preferences_card_desktop.dart';

class ShowJobsByPreferencesDesktop extends StatelessWidget {
  const ShowJobsByPreferencesDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        JobsPreferencesCardDesktop(),
        Expanded(child: BuildListViewJobsByPreferencesDesktop()),
      ],
    );
  }
}
