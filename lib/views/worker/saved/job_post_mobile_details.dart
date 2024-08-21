import 'package:flutter/material.dart';

import '../../../models/job_post.dart';
import '../../../services/fade_in_out.dart';
import '../../old_common_views/small_pop_button_widget.dart';
import 'mobile_job_post_details_components/apply_main_button_widget.dart';
import 'mobile_job_post_details_components/mobile_detail_page_block_five.dart';
import 'mobile_job_post_details_components/mobile_detail_page_block_four.dart';
import 'mobile_job_post_details_components/mobile_detail_page_block_one.dart';
import 'mobile_job_post_details_components/mobile_detail_page_block_three.dart';
import 'mobile_job_post_details_components/mobile_detail_page_block_two.dart';

class JobPostMobileDetails extends StatefulWidget {
  final JobPost jobPost;

  const JobPostMobileDetails({super.key, required this.jobPost});

  @override
  State<JobPostMobileDetails> createState() => _JobPostMobileDetailsState();
}

class _JobPostMobileDetailsState extends State<JobPostMobileDetails> {
  @override
  Widget build(BuildContext context) {
    double topPadding = MediaQuery.of(context).size.height * 0.1;

    // Create a ScrollController to track the scroll position
    ScrollController scrollController = ScrollController();

    return Stack(
      children: [
        SingleChildScrollView(
          controller: scrollController,
          child: Container(
            padding: EdgeInsets.only(left: 25, top: topPadding, right: 15),
            child: Column(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MobileDetailPageBlockOne(jobPost: widget.jobPost),
                    const SizedBox(height: 30),
                    const Divider(),
                    MobileDetailPageBlockTwo(jobPost: widget.jobPost),
                    const SizedBox(height: 30),
                    const Divider(),
                    MobileDetailPageBlockThree(jobPost: widget.jobPost),
                    const SizedBox(height: 30),
                    const Divider(),
                    MobileDetailPageBlockFour(jobPost: widget.jobPost),
                    const SizedBox(height: 30),
                    const Divider(),
                    MobileDetailPageBlockFive(jobPost: widget.jobPost),
                    const SizedBox(height: 30),
                    const Divider(),
                  ],
                ),
              ],
            ),
          ),
        ),
        const Positioned(
          top: 12, // Adjust as needed
          left: 10, // Adjust as needed
          child: SmallPopButtonWidget(),
        ),
        Positioned(
          bottom: 12,
          left: 15,
          right: 15,
          child: FadeInOutWidget(
              child: ApplyButtonWidget(jobPost: widget.jobPost)),

        ),
      ],
    );
  }
}
