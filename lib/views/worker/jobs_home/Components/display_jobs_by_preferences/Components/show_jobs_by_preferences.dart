import 'package:flutter/material.dart';

import '../../../../saved/build_list_view_jobs.dart';
import 'jobs_preferences_card.dart';

class ShowJobsByPreferences extends StatelessWidget {
  const ShowJobsByPreferences({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        JobsPreferencesCard(),
        Expanded(child: BuildListViewJobs()),
      ],
    );
  }
}
