import 'package:blukers/views/company/workers_home/workers_components/display_workers.dart';
import 'package:blukers/views/worker/select_job_industry/widgets/industry_widget.dart';
import 'package:blukers/views/worker/select_job_industry/widgets/search_header_desktop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../../../../../providers/app_settings_provider.dart';
import '../../../../../../providers/industry_provider.dart';
import '../../../../../../providers/job_posts_provider.dart';
import '../../../models/job.dart';
import '../../../providers/user_provider_parts/user_provider.dart';
import '../../../providers/worker_provider.dart';
import '../../../services/responsive.dart';
import '../../../utils/styles/theme_colors.dart';
import '../../common_vieiws/loading_page.dart';
import '../saved/display_jobs.dart';
import '../search_jobs/jobs_search_result_page/job_search_result_page.dart';

class SelectIndustryScreenDesktop extends StatefulWidget {
  const SelectIndustryScreenDesktop({super.key});

  @override
  State<SelectIndustryScreenDesktop> createState() =>
      _SelectIndustryScreenDesktopState();
}

class _SelectIndustryScreenDesktopState
    extends State<SelectIndustryScreenDesktop> {
  late AppSettingsProvider asp;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final prefs = await SharedPreferences.getInstance();
      final hasShowcased =
          prefs.getBool('showcaseShown') ?? false; // Default to false

      if (!hasShowcased) {
        final asp = Provider.of<AppSettingsProvider>(context, listen: false);
        final showcase = ShowCaseWidget.of(context);
        showcase.startShowCase([
          asp.signInButton,
          asp.bottomNavigation,
          asp.searchBar,
          asp.selection,
          asp.translation,
        ]);
        await prefs.setBool('showcaseShown', true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    IndustriesProvider ip = Provider.of<IndustriesProvider>(context);
    JobPostsProvider jp = Provider.of<JobPostsProvider>(context);
    asp = Provider.of<AppSettingsProvider>(context);
    final screenWidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
              width: screenWidth * 0.6, child: const SearchHeaderDesktop()),
          const SizedBox(
            height: 10,
          ),
          AnimatedCrossFade(
            firstChild: ip.industries.isEmpty
                ? const LoadingPage()
                : Showcase(
                    key: asp.selection,
                    description: 'Use this section to Select Jobs by industry',
                    targetShapeBorder: const CircleBorder(),
                    overlayOpacity: 0.6,
                    tooltipBackgroundColor:
                        const Color.fromRGBO(30, 117, 187, 1),
                    descTextStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 30.0),
                            child: Text(
                                AppLocalizations.of(context)!.selectAnIndustry,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.montserrat(
                                  fontSize: 28.0,
                                  fontWeight: FontWeight.w700,
                                  color: ThemeColors.black1ThemeColor,
                                )),
                          ),

                          Container(
                            width: (Responsive.isDesktop(context))
                                ? MediaQuery.of(context).size.width * 0.45
                                : MediaQuery.of(context).size.width * 0.8,
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.transparent,
                                style: BorderStyle.solid,
                                // width: 2.0,
                              ),
                              // color: Color(0xFFF05A22),
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            child: Column(
                              children: ip.industries.values.map((industry) {
                                return Container(
                                  margin: const EdgeInsets.only(
                                      bottom: 10.0, left: 30, right: 30),
                                  child: Builder(builder: (context) {
                                    WorkersProvider wp =
                                        Provider.of<WorkersProvider>(context);
                                    UserProvider up =
                                        Provider.of<UserProvider>(context);

                                    return IndustryWidget(
                                      industry: industry,
                                      getRecords:
                                          (BuildContext context, Job job) {
                                        if (up.userRole == 'company') {
                                          wp.getWorkersByJobID(job.jobId);
                                          // navigate anonymously to the DisplayWorkers page
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  DisplayWorkers(
                                                title: job.title,
                                              ),
                                            ),
                                          );
                                        } else {
                                          // navigate anonymously to the DisplayWorkers page
                                          jp.getJobPostsByJobID(
                                              job.title, up.userLanguage);
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) => DisplayJobs(
                                                title: job.title,
                                              ),
                                            ),
                                          );
                                        }
                                      },
                                    );
                                  }),
                                );
                              }).toList(),
                            ),
                          ),
                          // Bottom Space
                          const SizedBox(height: 60),
                        ],
                      ),
                    )),
            secondChild: const JobSearchResultPage(),
            crossFadeState: jp.isSearching
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 500),
          ),
        ],
      ),
    );
  }
}
