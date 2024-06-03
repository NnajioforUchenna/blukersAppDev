import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../models/job_post.dart';
import '../../../../../providers/company_provider.dart';
import '../../../../../utils/styles/theme_colors.dart';
import '../../../../old_common_views/small_pop_button_widget.dart';
import '../../../../worker/saved/mobile_job_post_details_components/mobile_detail_page_block_five.dart';
import '../../../../worker/saved/mobile_job_post_details_components/mobile_detail_page_block_four.dart';
import '../../../../worker/saved/mobile_job_post_details_components/mobile_detail_page_block_three.dart';
import '../../../../worker/saved/mobile_job_post_details_components/mobile_detail_page_block_two.dart';
import 'delete_post_dialog.dart';
import 'mobile_details_page_block_one_company.dart';

class JobPostMobileDetailsCompany extends StatefulWidget {
  final JobPost jobPost;

  const JobPostMobileDetailsCompany({super.key, required this.jobPost});

  @override
  State<JobPostMobileDetailsCompany> createState() =>
      _JobPostMobileDetailsCompanyState();
}

class _JobPostMobileDetailsCompanyState
    extends State<JobPostMobileDetailsCompany> {
  @override
  Widget build(BuildContext context) {
    double topPadding = MediaQuery.of(context).size.height * 0.1;
    CompanyProvider cp = Provider.of<CompanyProvider>(context, listen: false);
    bool canDelete = cp.appUser!.uid == widget.jobPost.companyId;

    // Create a ScrollController to track the scroll position
    ScrollController scrollController = ScrollController();

    return Stack(
      children: [
        SingleChildScrollView(
          controller: scrollController,
          child: Container(
            padding: EdgeInsets.only(
                left: 25, top: topPadding, right: 15, bottom: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MobileDetailPageBlockOneCompany(jobPost: widget.jobPost),
                MobileDetailPageBlockTwo(jobPost: widget.jobPost),
                MobileDetailPageBlockThree(jobPost: widget.jobPost),
                MobileDetailPageBlockFour(jobPost: widget.jobPost),
                MobileDetailPageBlockFive(jobPost: widget.jobPost),
                const SizedBox(height: 20),
                if (canDelete)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: ThemeColors.secondaryThemeColor,
                          textStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return DeleteDialog(jobPost: widget.jobPost);
                            },
                          );
                        },
                        child: const Text('Delete Job Post'),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: ThemeColors.secondaryThemeColor,
                          textStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        onPressed: () {
                          // editJobPost(context);
                        },
                        child: const Text('Edit Job Post'),
                      ),
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
      ],
    );
  }
}
