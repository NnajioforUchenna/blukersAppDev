import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../providers/worker_provider.dart';

import '../common_vieiws/all_search_bar_components/all_search_bar.dart';
import '../common_vieiws/loading_page.dart';
import '../common_vieiws/page_template/page_template.dart';
import '../old_common_views/select_industry_components/display_industries.dart';
import 'workers_components/worker_search_result_page.dart';
import 'package:provider/provider.dart';
import '../../providers/app_versions_provider.dart';

import '../../providers/industry_provider.dart';

class Workers extends StatelessWidget {
  const Workers({super.key});

  @override
  Widget build(BuildContext context) {
    IndustriesProvider ip = Provider.of<IndustriesProvider>(context);
    WorkerProvider wp = Provider.of<WorkerProvider>(context);
    AppVersionsProvider avp = Provider.of<AppVersionsProvider>(context);

    if (!kIsWeb) {
      avp.checkForUpdate(context);
    }

    return PageTemplate(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const AllSearchBar(),
            const SizedBox(height: 10),
            const Divider(),
            AnimatedCrossFade(
              firstChild: ip.industries.isEmpty
                  ? LoadingPage()
                  : const DisplayIndustries(),
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
