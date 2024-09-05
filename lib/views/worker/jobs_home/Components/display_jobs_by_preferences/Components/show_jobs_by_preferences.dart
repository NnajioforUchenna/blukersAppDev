import 'package:flutter/material.dart';

import 'Jobs_preferences_card/Mobile_job_card/mobile_jobs_preferences_card.dart';
import 'build_list_view_jobs_by_preferences.dart';


class ShowJobsByPreferences extends StatelessWidget {
  const ShowJobsByPreferences({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        MobileJobsPreferencesCard(),
        Expanded(child: BuildListViewJobsByPreferences()),
      ],
    );
  }
}
