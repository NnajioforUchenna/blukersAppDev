import 'package:flutter/material.dart';

import '../../../../../services/responsive.dart';
import '../../../saved/animate_job_post_details.dart';
import 'Components/build_list_view_jobs_by_preferences.dart';

class BuildListViewJobsByPreferencesDesktop extends StatelessWidget {
  const BuildListViewJobsByPreferencesDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Responsive.isDesktop(context)
          ? MediaQuery.of(context).size.width * 0.85
          : null,
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1st column
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 8, top: 8),
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
      ),
    );
  }
}
