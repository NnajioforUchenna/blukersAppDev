import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/app_settings_provider.dart';
import '../../providers/industry_provider.dart';
import '../../providers/worker_provider.dart';
import '../common_vieiws/all_search_bar_components/all_search_bar.dart';
import '../common_vieiws/loading_page.dart';
import '../worker/jobs_home/worker_home_components/jobs_mobile_view/jobs_mobile_view_compnents/mobile_industry_headpanel.dart';
import '../worker/worker_page_template/worker_page_template.dart';
import 'workers_components/worker_search_result_page.dart';

class Workers extends StatelessWidget {
  const Workers({super.key});

  @override
  Widget build(BuildContext context) {
    IndustriesProvider ip = Provider.of<IndustriesProvider>(context);
    WorkerProvider wp = Provider.of<WorkerProvider>(context);
    AppSettingsProvider avp = Provider.of<AppSettingsProvider>(context);

    if (!kIsWeb) {
      avp.checkForUpdate(context);
    }

    return WorkerPageTemplate(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const AllSearchBar(),
            const SizedBox(height: 10),
            const Divider(),
            AnimatedCrossFade(
              firstChild: ip.industries.isEmpty
                  ? LoadingPage()
                  : Column(
                      children: ip.industries.values.map((industry) {
                        return Container(
                          margin: const EdgeInsets.only(
                              bottom: 10.0, left: 30, right: 30),
                          child: MobileIndustryHeadPanel(industry: industry),
                        );
                      }).toList(),
                    ),
              secondChild: const WorkerSearchResultPage(),
              crossFadeState: wp.isSearching
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 500),
            ),
          ],
        ),
      ),
    );
  }
}
