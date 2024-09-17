import 'package:blukers/providers/jobs_lists_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';

import '../../../../providers/user_provider_parts/user_provider.dart';
import '../../common_vieiws/icon_text_404.dart';
import 'list_job_posts_widget.dart';

class SavedJobs extends StatefulWidget {
  const SavedJobs({super.key});

  @override
  State<SavedJobs> createState() => _SavedJobsState();
}

class _SavedJobsState extends State<SavedJobs> {
  bool _isInitialized = false; // Flag to track initialization

  @override

  void didChangeDependencies() {
    super.didChangeDependencies();

    // Ensure that the initialization logic is executed only once
    if (!_isInitialized) {
      final up = Provider.of<UserProvider>(context, listen: false);
      final jpp = Provider.of<JobsListsProvider>(context, listen: false);

      // Call the function only if up.appUser is not null
      if (up.appUser != null) {
        jpp.getSavedJobPostByIds();
      }

      _isInitialized = true; // Set the flag to true to prevent re-execution
    }
  }

  @override
  Widget build(BuildContext context) {
    // Access JobsListsProvider to get the list of saved job posts
    JobsListsProvider jpp = Provider.of<JobsListsProvider>(context);

    return jpp.savedJobPosts.isEmpty
        ? IconText404(
            text: AppLocalizations.of(context)!.youHaveNotSavedAnyJobPost,
            icon: UniconsLine.file_bookmark_alt,
          )
        : ListJobPostsWidget(
            jobPosts: jpp.savedJobPosts.values.toList(),
          );
  }
}
