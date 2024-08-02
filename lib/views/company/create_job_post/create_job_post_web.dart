import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'create_job_post_components/job_post_page_slider.dart';
import 'create_job_post_components/job_post_time_line.dart';

class CreateJobPostWeb extends StatelessWidget {
  const CreateJobPostWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.createJobPost),
      ),
      body: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                borderRadius: BorderRadius.circular(15),
                elevation: 5,
                color: Colors.orangeAccent,
                child: Image.network('https://cdn.dribbble.com/users/2058540/screenshots/8225181/media/b58d8e704437b76d915877b2cc4d1bc7.gif'),
              ),
            ),
          ),
          Expanded(
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
        ],
      ),
    );
  }
}
