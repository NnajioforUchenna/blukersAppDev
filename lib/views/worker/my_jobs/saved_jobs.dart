import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';

import '../../../../models/job_post.dart';
import '../../../../providers/job_posts_provider.dart';
import '../../../../providers/user_provider_parts/user_provider.dart';
import '../../common_vieiws/icon_text_404.dart';
import '../../common_vieiws/policy_terms/policy_terms_components/loading_animation.dart';
import 'list_job_posts_widget.dart';

class SavedJobs extends StatefulWidget {
  const SavedJobs({super.key});

  @override
  State<SavedJobs> createState() => _SavedJobsState();
}

class _SavedJobsState extends State<SavedJobs> {
  late Future<List<JobPost>> jobPosts;

  @override
  void initState() {
    super.initState();
    final up = Provider.of<UserProvider>(context, listen: false);
    final jpp = Provider.of<JobPostsProvider>(context, listen: false);
    if (up.appUser != null) {
      jobPosts = jpp.getSavedJobPostIds(up.appUser!.uid);
    } else {
      jobPosts = Future.value([]); // It's better to initialize in this way
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<JobPost>>(
      future: jobPosts,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingAnimation();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          List<JobPost> jobPosts = snapshot.data!;
          return jobPosts.isEmpty
              ? IconText404(
                  text: AppLocalizations.of(context)!.youHaveNotSavedAnyJobPost,
                  icon: UniconsLine.file_bookmark_alt)
              : ListJobPostsWidget(
                  jobPosts: snapshot.data!,
                );
        }
        return IconText404(
            text: AppLocalizations.of(context)!.youHaveNotSavedAnyJobPost,
            icon: UniconsLine.file_bookmark_alt);
      },
    );
  }
}
