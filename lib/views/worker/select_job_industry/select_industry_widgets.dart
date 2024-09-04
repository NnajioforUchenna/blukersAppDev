import 'package:blukers/utils/styles/theme_colors.dart';
import 'package:blukers/views/worker/select_job_industry/widgets/industry_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../../../../providers/app_settings_provider.dart';
import '../../../../../providers/industry_provider.dart';
import '../../../../../providers/job_posts_provider.dart';
import '../../common_vieiws/loading_page.dart';
import 'widgets/search_header_mobile.dart';

class SelectIndustryScreen extends StatefulWidget {
  const SelectIndustryScreen({super.key});

  @override
  State<SelectIndustryScreen> createState() => _SelectIndustryScreenState();
}

class _SelectIndustryScreenState extends State<SelectIndustryScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        final asp = Provider.of<AppSettingsProvider>(context, listen: false);
        if (!asp.hasShowcased) {
          // wait 200ms to allow the page to build
          await Future.delayed(const Duration(milliseconds: 200));
          ShowCaseWidget.of(context).startShowCase([
            asp.signInButton,
            asp.bottomNavigation,
            asp.searchBar,
            asp.selection,
            asp.translation,
          ]);
          asp.setHasShowcased(true);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    IndustriesProvider ip = Provider.of<IndustriesProvider>(context);
    JobPostsProvider jp = Provider.of<JobPostsProvider>(context);
    AppSettingsProvider asp = Provider.of<AppSettingsProvider>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // const SearchAndTranslateRow(),
        const SearchHeaderMobile(),
        Expanded(
          child: AnimatedCrossFade(
            firstChild: const LoadingPage(),
            secondChild: Showcase(
                key: asp.selection,
                description: 'Use this section to Select Jobs by industry',
                targetShapeBorder: const CircleBorder(),
                overlayOpacity: 0.6,
                tooltipBackgroundColor: const Color.fromRGBO(30, 117, 187, 1),
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
                            AppLocalizations.of(context)!.selectJobsAnIndustry,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.montserrat(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w700,
                              color: ThemeColors.black1ThemeColor,
                            )),
                      ),
                      Column(
                        children: ip.industries.values.map((industry) {
                          return Container(
                            margin: const EdgeInsets.only(
                                bottom: 17.0, left: 14, right: 14),
                            child: IndustryWidget(
                              industry: industry,
                              getRecords: jp.getJobsBySelection,
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 60),
                    ],
                  ),
                )),
            crossFadeState: ip.industries.isEmpty
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
            duration: const Duration(milliseconds: 500),
          ),
        ),
      ],
    );
  }
}
