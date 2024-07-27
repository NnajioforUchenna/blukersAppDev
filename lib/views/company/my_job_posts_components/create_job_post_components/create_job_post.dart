import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'job_post_page_slider.dart';
import 'job_post_time_line.dart';

class CreateJobPost extends StatelessWidget {
  const CreateJobPost({super.key});

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   // appBar: AppBar(
    //   //   backgroundColor: Colors.white,
    //   //   title: const Center(
    //   //     child: Text(
    //   //       'Creating Job Post',
    //   //       style: ThemeTextStyles.headerThemeTextStyle,
    //   //     ),
    //   //   ),
    //   // ),
    //   appBar: MyAppBar(
    //     title: "Create Job Post",
    //   ),
    //   body: Center(
    //     child: SizedBox(
    //       height: MediaQuery.of(context).size.height,
    //       width: Responsive.isDesktop(context)
    //           ? MediaQuery.of(context).size.width * 0.3
    //           : MediaQuery.of(context).size.width,
    //       child: CustomScrollView(
    //         slivers: [
    //           SliverList(
    //               delegate: SliverChildListDelegate([
    //             JobPostTimeline(),
    //             const SizedBox(
    //               height: 30.0,
    //             ),
    //             const JobPostPageSlider()
    //           ]))
    //         ],
    //       ),
    //     ),
    //   ),
    // );

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.createJobPost),
      ),
      body: Column(
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
    );
  }
}
