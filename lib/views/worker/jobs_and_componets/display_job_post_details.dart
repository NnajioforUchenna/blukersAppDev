import 'package:blukers/views/worker/jobs_and_componets/job_post_mobile_details.dart';
import 'package:flutter/material.dart';

import '../../../models/job_post.dart';
import '../../../services/responsive.dart';
import '../../common_views/loading_page.dart';
import 'job_post_desktop_details.dart';

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
      duration: const Duration(seconds: 2),
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

    return jobPost == null
        ? Center(child: SizedBox(height: 100, width: 100, child: LoadingPage()))
        : Responsive.isDesktop(context)
            ? JobPostDesktopDetails(
                jobPost: jobPost,
                animation: _animation,
              )
            : JobPostMobileDetails(jobPost: jobPost);
  }
}
