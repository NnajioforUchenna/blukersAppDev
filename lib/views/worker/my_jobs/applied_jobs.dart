import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';

import '../../../../providers/jobs_lists_provider.dart';
import '../../../../providers/user_provider_parts/user_provider.dart';
import '../../common_vieiws/icon_text_404.dart';
import 'list_job_posts_widget.dart';

class AppliedJobs extends StatefulWidget {
  const AppliedJobs({super.key});

  @override
  State<AppliedJobs> createState() => _AppliedJobsState();
}

class _AppliedJobsState extends State<AppliedJobs> {
  bool _isInitialized = false; // Flag to ensure the function is called once

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Ensure the function is called only once
    if (!_isInitialized) {
      final up = Provider.of<UserProvider>(context, listen: false);
      final jpp = Provider.of<JobsListsProvider>(context, listen: false);
      if (up.appUser != null) {
        jpp.getAppliedJobPostByIds(); // Call the function once
      }
      _isInitialized = true; // Set the flag to true to prevent re-execution
    }
  }

  @override
  Widget build(BuildContext context) {
    // Access the provider to get the list of applied job posts
    final jpp = Provider.of<JobsListsProvider>(context);

    return jpp.appliedJobPosts.isNotEmpty
        ? ListJobPostsWidget(
            jobPosts: jpp.appliedJobPosts.values.toList(), // Display job posts
          )
        : IconText404(
            text: AppLocalizations.of(context)!
                .youHaveNotAppliedToAnyJobPost, // Display if no job posts
            icon: UniconsLine.file_edit_alt,
          );
  }
}
