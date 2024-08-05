import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../saved/build_list_view_jobs.dart';
import 'jobs_preferences_card_desktop.dart';

class ShowJobsByPreferencesDesktop extends StatelessWidget {
  const ShowJobsByPreferencesDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 80.sp),
          child: const JobsPreferencesCardDesktop(),
        ),
        const Expanded(child: BuildListViewJobsDesktop()),
      ],
    );
  }
}
