import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';

import '../../../../models/job_post.dart';
import '../../../../providers/company_provider.dart';
import '../../../common_vieiws/icon_text_404.dart';
import '../../../common_vieiws/policy_terms/policy_terms_components/loading_animation.dart';
import 'my_job_post_component/job_post_company/complete_job_post_widget_company.dart';

class MyJobPostsTab extends StatelessWidget {
  const MyJobPostsTab({super.key});

  @override
  Widget build(BuildContext context) {
    CompanyProvider cp = Provider.of<CompanyProvider>(context);

    return StreamBuilder<List<JobPost>>(
      stream: cp.getMyJobPostsStream(),
      // Assuming CompanyProvider has a similar function to fetch the job posts stream.
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingAnimation();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          // return NoMyJobPosts();
          return IconText404(
              text: AppLocalizations.of(context)!.youHaveNotCreatedAnyJobPost,
              icon: UniconsLine.file_alt);
        } else {
          List<JobPost> jobPosts = snapshot.data!;
          return CompanyCompleteJobPostWidget(jobPosts: jobPosts);
        }
      },
    );
  }
}
