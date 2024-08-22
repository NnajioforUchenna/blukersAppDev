import 'package:flutter/material.dart';

import 'build_list_view_jobs_by_preferences.dart';
import 'jobs_preferences_card.dart';

class ShowJobsByPreferences extends StatelessWidget {
  const ShowJobsByPreferences({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        //JobsPreferencesCard(),
        Expanded(child: BuildListViewJobsByPreferences()),
      ],
    );
  }
}
