import 'package:flutter/material.dart';

import '../../../models/job_post.dart';
import '../jobs_and_componets/complete_job_posts_widget.dart';

class WebJobSearchResultPage extends StatelessWidget {
  final List<JobPost> toDisplay;
  const WebJobSearchResultPage({super.key, required this.toDisplay});

  @override
  Widget build(BuildContext context) {
    return CompleteJobPostWidget(jobPosts: toDisplay);
  }
}
