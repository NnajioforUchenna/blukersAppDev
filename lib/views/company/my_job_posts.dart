import 'package:bulkers/providers/job_posts_provider.dart';
import 'package:bulkers/services/responsive.dart';
import 'package:bulkers/views/common_views/page_template/page_template.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/user_provider.dart';
import '../../utils/styles/theme_colors.dart';
import '../common_views/worker_timeline/display_worker_timeline_dialog.dart';
import 'my_job_posts_components/interesting_workers_tab.dart';
import 'my_job_posts_components/my_job_posts_tab.dart';
import 'package:unicons/unicons.dart';

class MyJobPosts extends StatelessWidget {
  const MyJobPosts({super.key});

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
                Tab(text: 'Saved Workers', icon: Icon(UniconsLine.constructor)),
                Tab(text: 'My Jobs', icon: Icon(UniconsLine.file_alt)),
              ],
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: InkWell(
                  onTap: () {
                    if (up.companyTimelineStep < 2) {
                      showDialog(
                          context: context,
                          builder: (context) =>
                              const DisplayWorkerTimelineDialog());
                    } else {
                      jpp.createNewJobPost(up.appUser, context);
                    }
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(UniconsLine.file_plus_alt,
                          color: ThemeColors
                              .secondaryThemeColor), // Use Icon instead of IconButton
                      if (Responsive.isDesktop(context))
                        const Padding(
                          padding: EdgeInsets.only(left: 4.0),
                          child: Text('New',
                              style: TextStyle(
                                  color: ThemeColors.secondaryThemeColor)),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          body: const TabBarView(
            children: [
              InterestingWorkersTab(),
              MyJobPostsTab(),
            ],
          ),
        ),
      ),
    );
  }
}
