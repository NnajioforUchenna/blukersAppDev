import 'package:flutter/material.dart';

import '../../../saved/animate_job_post_details.dart';
import 'Components/build_list_view_jobs_by_preferences.dart';

class BuildListViewJobsByPreferencesDesktop extends StatelessWidget {
  const BuildListViewJobsByPreferencesDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1st column
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: BuildListViewJobsByPreferences(),
          ),
        ),
        // 2nd column
        Expanded(
          flex: 2,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(child: AnimateJobPostDetails()),
          ),
        ),
      ],
    );
  }
}
