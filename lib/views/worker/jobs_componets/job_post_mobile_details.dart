import 'package:flutter/material.dart';

import '../../../models/job_post.dart';
import '../../../services/fade_in_out.dart';
import '../../common_views/small_pop_button_widget.dart';
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
  bool isButtonVisible = false;

  @override
  Widget build(BuildContext context) {
    double topPadding = MediaQuery.of(context).size.height * 0.1;

    // Create a ScrollController to track the scroll position
    ScrollController _scrollController = ScrollController();

    // Add a listener to the ScrollController to toggle button visibility
    _scrollController.addListener(() {
      setState(() {
        isButtonVisible = _scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent -
                (MediaQuery.of(context).size.height * 0.1);
      });
    });

    return Stack(
      children: [
        SingleChildScrollView(
          controller: _scrollController,
          child: Container(
            padding: EdgeInsets.only(left: 25, top: topPadding, right: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MobileDetailPageBlockOne(jobPost: widget.jobPost),
                MobileDetailPageBlockTwo(jobPost: widget.jobPost),
                MobileDetailPageBlockThree(jobPost: widget.jobPost),
                MobileDetailPageBlockFour(jobPost: widget.jobPost),
                MobileDetailPageBlockFive(jobPost: widget.jobPost),
                FadeInOutWidget(
                    child: ApplyButtonWidget(jobPost: widget.jobPost)),
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              ],
            ),
          ),
        ),
        const Positioned(
          top: 12, // Adjust as needed
          left: 10, // Adjust as needed
          child: SmallPopButtonWidget(),
        ),
        if (!isButtonVisible)
          Positioned(
            left: 0.0,
            right: 0.0,
            bottom: 10.0, // Adjust as needed to create the desired spacing
            child: FadeInOutWidget(
                child: ApplyButtonWidget(jobPost: widget.jobPost)),
          ),
      ],
    );
  }
}
