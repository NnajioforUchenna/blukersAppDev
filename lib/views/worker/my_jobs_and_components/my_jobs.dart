import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';

import '../../../providers/job_posts_provider.dart';
import '../../../providers/user_provider_parts/user_provider.dart';
import '../../../utils/styles/theme_colors.dart';
import '../../common_views/page_template/page_template.dart';
import '../my_jobs_and_components/applied_jobs.dart';
import '../my_jobs_and_components/saved_jobs.dart';

class MyJobs extends StatelessWidget {
  const MyJobs({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider up = Provider.of<UserProvider>(context);
    JobPostsProvider jpp = Provider.of<JobPostsProvider>(context);
    return PageTemplate(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            centerTitle: true,
            title: Text(
              AppLocalizations.of(context)!.jobs,
              style: const TextStyle(
                  color: ThemeColors.primaryThemeColor,
                  fontWeight: FontWeight.bold),
            ),
            bottom: TabBar(
              indicatorColor: ThemeColors.primaryThemeColor,
              labelColor: ThemeColors.primaryThemeColor,
              unselectedLabelColor: ThemeColors.grey1ThemeColor,
              tabs: [
                Tab(
                    text: AppLocalizations.of(context)!.applied,
                    icon: const Icon(UniconsLine.file_edit_alt)),
                Tab(
                    text: AppLocalizations.of(context)!.saved,
                    icon: const Icon(UniconsLine.file_bookmark_alt)),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              AppliedJobs(),
              SavedJobs(),
            ],
          ),
        ),
      ),
    );
  }
}