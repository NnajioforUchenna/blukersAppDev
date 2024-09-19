import 'package:flutter/material.dart';

import '../build_list_view_jobs_by_preferences_desktop.dart';
import 'Jobs_preferences_card/Desktop_job_card/jobs_preferences_card_desktop.dart';

class ShowJobsByPreferencesDesktop extends StatefulWidget {
  const ShowJobsByPreferencesDesktop({super.key});

  @override
  State<ShowJobsByPreferencesDesktop> createState() => _ShowJobsByPreferencesDesktopState();
}

class _ShowJobsByPreferencesDesktopState extends State<ShowJobsByPreferencesDesktop> {
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
