import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'create_job_post_components/job_post_page_slider.dart';
import 'create_job_post_components/job_post_time_line.dart';

class CreateJobPostMobile extends StatelessWidget {
  const CreateJobPostMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.createJobPost),
      ),
      body: SizedBox(
        height:double.infinity ,
        width: double.infinity,
        child: Column(
          children: [
            JobPostTimeline(),
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        const JobPostPageSlider(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
