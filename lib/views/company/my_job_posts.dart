import '../../providers/job_posts_provider.dart';
import '../../services/responsive.dart';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';

import '../../providers/user_provider_parts/user_provider.dart';
import '../../utils/styles/theme_colors.dart';

import '../common_vieiws/page_template/page_template.dart';
import '../old_common_views/worker_timeline/display_worker_timeline_dialog.dart';
import 'my_job_posts_components/interesting_workers_tab.dart';
import 'my_job_posts_components/my_job_posts_tab.dart';

import '../auth/common_widget/login_or_register.dart';

class MyJobPosts extends StatelessWidget {
  const MyJobPosts({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider up = Provider.of<UserProvider>(context);
    JobPostsProvider jpp = Provider.of<JobPostsProvider>(context);
    return PageTemplate(
      child: up.appUser == null
          ? const LoginOrRegister()
          : DefaultTabController(
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
                          text: AppLocalizations.of(context)!.savedWorkers,
                          icon: const Icon(UniconsLine.constructor)),
                      Tab(
                          text: AppLocalizations.of(context)!.myJobs,
                          icon: const Icon(UniconsLine.file_alt)),
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
                                        color:
                                            ThemeColors.secondaryThemeColor)),
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
