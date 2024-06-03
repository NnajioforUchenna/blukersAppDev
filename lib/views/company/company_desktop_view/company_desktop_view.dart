import 'package:blukers/views/common_vieiws/all_search_bar_components/company_desktop_search_bar.dart';

import 'package:blukers/views/common_vieiws/loading_page.dart';
import 'package:blukers/views/company/workers_components/worker_search_result_page.dart';
import 'package:blukers/views/old_common_views/select_industry_components/display_industries.dart';
import 'package:blukers/views/worker/worker_home/worker_home_components/jobs_desktop_view/select_desktop_language_dialog.dart';
import '../../../../../providers/industry_provider.dart';
import '../../../../../providers/job_posts_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CompanyDesktop extends StatefulWidget {
  const CompanyDesktop({Key? key}) : super(key: key);

  @override
  State<CompanyDesktop> createState() => _CompanyDesktopState();
}

class _CompanyDesktopState extends State<CompanyDesktop> {
  @override
  Widget build(BuildContext context) {
    IndustriesProvider ip = Provider.of<IndustriesProvider>(context);
    JobPostsProvider jp = Provider.of<JobPostsProvider>(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          const CompanyDesktopSearchBar(),
          const SizedBox(
            height: 10,
          ),
          const Center(
            child: SelectDesktopLanguageDialog(),
          ),
          const SizedBox(
            height: 10,
          ),
          const Divider(),
          AnimatedCrossFade(
            firstChild: ip.industries.isEmpty
                ? const LoadingPage()
                : const DisplayIndustries(),
            secondChild: const WorkerSearchResultPage(),
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
