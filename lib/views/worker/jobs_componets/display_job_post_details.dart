import 'package:blukers/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/job_post.dart';
import '../../../utils/styles/theme_colors.dart';
import '../../common_views/loading_page.dart';
import 'job_post_details_component/detail_page_block_five.dart';
import 'job_post_details_component/detail_page_block_four.dart';
import 'job_post_details_component/detail_page_block_one.dart';
import 'job_post_details_component/detail_page_block_three.dart';
import 'job_post_details_component/detail_page_block_two.dart';

class JobPostDetailsWidget extends StatefulWidget {
  final JobPost? jobPost;

  const JobPostDetailsWidget({required this.jobPost, Key? key})
      : super(key: key);

  @override
  _JobPostDetailsWidgetState createState() => _JobPostDetailsWidgetState();
}

class _JobPostDetailsWidgetState extends State<JobPostDetailsWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    _animation = CurvedAnimation(
        parent: _controller, curve: Curves.easeInOut); // Add a curve
    _controller.forward();
  }

  @override
  void didUpdateWidget(covariant JobPostDetailsWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.jobPost != widget.jobPost) {
      _controller.reset();
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    JobPost? jobPost = widget.jobPost;
    UserProvider up = Provider.of<UserProvider>(context);

    return jobPost == null
        ? Center(child: SizedBox(height: 100, width: 100, child: LoadingPage()))
        : Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Card(
              elevation: 5,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      width: 2,
                      color: ThemeColors.primaryThemeColor,
                    ),
                  ),
                ),
                child: FadeTransition(
                  opacity: _animation,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        DetailPageBlockOne(jobPost: jobPost),
                        DetailPageBlockTwo(jobPost: jobPost),
                        DetailPageBlockThree(jobPost: jobPost),
                        DetailPageBlockFour(jobPost: jobPost),
                        if (up.appUser != null &&
                            up.appUser!.uid == jobPost.companyId)
                          DetailPageBlockFive(jobPost: jobPost),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}
