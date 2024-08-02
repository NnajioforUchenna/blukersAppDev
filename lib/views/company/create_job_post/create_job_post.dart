import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'create_job_post_components/job_post_page_slider.dart';
import 'create_job_post_components/job_post_time_line.dart';

class CreateJobPost extends StatelessWidget {
  const CreateJobPost({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.createJobPost),
      ),
      body: Column(
        children: [
          JobPostTimeline(),
          const Expanded(child: JobPostPageSlider()),
        ],
      ),
    );
  }
}
