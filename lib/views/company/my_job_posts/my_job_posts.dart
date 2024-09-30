import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';

import '../../../providers/job_posts_provider.dart';
import '../../../providers/user_provider_parts/user_provider.dart';
import '../../../services/responsive.dart';
import '../../../utils/styles/theme_colors.dart';
import '../../auth/common_widget/login_or_register.dart';
import '../../old_common_views/worker_timeline/display_worker_timeline_dialog.dart';
import 'my_job_posts_components/interesting_workers_tab.dart';
import 'my_job_posts_components/my_job_posts_tab.dart';

class MyJobPosts extends StatefulWidget {
  const MyJobPosts({super.key});

  @override
  State<MyJobPosts> createState() => _MyJobPostsState();
}

class _MyJobPostsState extends State<MyJobPosts>
    with SingleTickerProviderStateMixin {
  late final tabController = TabController(length: 2, vsync: this);

  @override
  Widget build(BuildContext context) {
    UserProvider up = Provider.of<UserProvider>(context);
    JobPostsProvider jp = Provider.of<JobPostsProvider>(context);
    return up.appUser == null
        ? const LoginOrRegister()
        : DefaultTabController(
            length: 2,
            child: Scaffold(
              backgroundColor: Colors.white,
              body: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Column(
                  children: [
                    SizedBox(
                      width: Responsive.isMobile(context)
                          ? MediaQuery.of(context).size.width * 0.96
                          : MediaQuery.of(context).size.width * 0.9,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                constraints: const BoxConstraints(),
                                onPressed: () {
                                  GoRouter.of(context).go('/workers');
                                },
                                icon: const Icon(
                                  Icons.arrow_back,
                                  color: Colors.black,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  if (up.companyTimelineStep < 2) {
                                    showDialog(
                                        context: context,
                                        builder: (context) =>
                                            const DisplayWorkerTimelineDialog());
                                  } else {
                                    jp.createNewJobPost(up.appUser, context);
                                  }
                                },
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(UniconsLine.file_plus_alt,
                                        color: ThemeColors.secondaryThemeColor),
                                    // Use Icon instead of IconButton
                                    if (Responsive.isDesktop(context))
                                      const Padding(
                                        padding: EdgeInsets.only(left: 4.0),
                                        child: Text('New',
                                            style: TextStyle(
                                                color: ThemeColors
                                                    .secondaryThemeColor)),
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TabBar(
                            onTap: (index) {
                              setState(() {});
                            },
                            controller: tabController,
                            indicatorColor: Colors.black,
                            indicatorSize: TabBarIndicatorSize.tab,
                            indicatorWeight: 3,
                            labelColor: Colors.black,
                            unselectedLabelColor:
                                Colors.black.withOpacity(0.30),
                            labelStyle: GoogleFonts.montserrat(
                                fontSize:
                                    Responsive.isMobile(context) ? 16 : 20,
                                fontWeight: FontWeight.w500),
                            tabs: [
                              Tab(
                                  text: AppLocalizations.of(context)!
                                      .savedWorkers,
                                  icon: Icon(
                                    Icons.bookmark,
                                    size:
                                        Responsive.isMobile(context) ? 25 : 30,
                                  )),
                              Tab(
                                text: AppLocalizations.of(context)!.myJobs,
                                icon: Icon(
                                  UniconsLine.briefcase,
                                )
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Center(
                          child: SizedBox(
                            width: Responsive.isMobile(context)
                                ? double.infinity
                                : MediaQuery.of(context).size.width * 0.9,
                            child: TabBarView(
                              controller: tabController,
                              children: const [
                                InterestingWorkersTab(),
                                MyJobPostsTab(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
