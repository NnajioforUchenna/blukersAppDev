import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/job_posts_provider.dart';
import '../../providers/user_provider.dart';
import '../../utils/styles/theme_colors.dart';
import '../common_views/page_template/page_template.dart';
import 'my_jobs_components/applied_jobs.dart';
import 'my_jobs_components/saved_jobs.dart';
import 'package:unicons/unicons.dart';

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
            title: const Text(
              'Jobs',
              style: TextStyle(
                  color: ThemeColors.primaryThemeColor,
                  fontWeight: FontWeight.bold),
            ),
            bottom: const TabBar(
              indicatorColor: ThemeColors.primaryThemeColor,
              labelColor: ThemeColors.primaryThemeColor,
              unselectedLabelColor: ThemeColors.grey1ThemeColor,
              tabs: [
                Tab(text: 'Applied', icon: Icon(UniconsLine.file_edit_alt)),
                Tab(text: 'Saved', icon: Icon(UniconsLine.file_bookmark_alt)),
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
