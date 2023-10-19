import 'package:blukers/models/job_post.dart';
import 'package:blukers/providers/company_provider.dart';
import 'package:blukers/providers/job_posts_provider.dart';
import 'package:blukers/views/common_views/components/icon_text_404.dart';
import 'package:blukers/views/worker/jobs_and_componets/complete_job_posts_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';
import 'package:blukers/views/common_views/components/loading_animation.dart';

class MyJobPostsTab extends StatelessWidget {
  const MyJobPostsTab({super.key});

  @override
  Widget build(BuildContext context) {
    CompanyProvider cp = Provider.of<CompanyProvider>(context);
    JobPostsProvider jpp = Provider.of<JobPostsProvider>(context);

    return StreamBuilder<List<JobPost>>(
      stream: cp
          .getMyJobPostsStream(), // Assuming CompanyProvider has a similar function to fetch the job posts stream.
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingAnimation();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          // return NoMyJobPosts();
          return IconText404(
              text: AppLocalizations.of(context)!.youHaveNotCreatedAnyJobPost,
              icon: UniconsLine.file_alt);
        } else {
          List<JobPost> jobPosts = snapshot.data!;
          return CompleteJobPostWidget(jobPosts: jobPosts);
        }
      },
    );
  }
}
