import 'package:blukers/views/common_vieiws/loading_page.dart';
import 'package:blukers/views/company/company_mobile_view/mobile_display_industries_company.dart';
import 'package:blukers/views/company/company_mobile_view/search_and_translate_row_company.dart';
import 'package:blukers/views/company/workers_components/worker_search_result_page.dart';
import 'package:blukers/views/worker/worker_home/worker_home_components/jobs_mobile_view/jobs_mobile_view_compnents/sign_in_row.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../../../../providers/app_settings_provider.dart';
import '../../../../../providers/industry_provider.dart';
import '../../../../../providers/job_posts_provider.dart';
class CompanyMobile extends StatefulWidget {
  const CompanyMobile({super.key});

  @override
  State<CompanyMobile> createState() => _CompanyMobileState();
}

class _CompanyMobileState extends State<CompanyMobile> {
  late AppSettingsProvider asp;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final asp = Provider.of<AppSettingsProvider>(context, listen: false);
      if (!asp.hasShowcased) {
        final showcase = ShowCaseWidget.of(context);
        showcase.startShowCase([
          asp.signInButton,
          asp.bottomNavigation,
          asp.searchBar,
          asp.selection,
          asp.translation,
        ]);
        asp.setHasShowcased(true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    IndustriesProvider ip = Provider.of<IndustriesProvider>(context);
    JobPostsProvider jp = Provider.of<JobPostsProvider>(context);
    asp = Provider.of<AppSettingsProvider>(context);

    return Column(
      children: [
        const SignInRow(),
        const SearchAndTranslateRow(),
        Expanded(
          child: AnimatedCrossFade(
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
                    child: const CompanyMobileDisplayIndustries()),
            secondChild: const WorkerSearchResultPage(),
            crossFadeState: jp.isSearching
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 500),
          ),
        ),
      ],
    );
  }
}
