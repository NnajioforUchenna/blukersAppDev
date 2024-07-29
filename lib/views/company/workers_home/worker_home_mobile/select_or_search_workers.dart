import 'package:blukers/views/company/workers_home/worker_home_mobile/search_and_translate_row.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../../../../../providers/app_settings_provider.dart';
import '../../../../../../providers/industry_provider.dart';
import '../../../../providers/worker_provider.dart';
import '../../../Modules/select_by_industry/select_by_industry.dart';
import '../../../common_vieiws/loading_page.dart';

class SelectOrSearchWorkers extends StatefulWidget {
  const SelectOrSearchWorkers({super.key});

  @override
  State<SelectOrSearchWorkers> createState() => _SelectOrSearchWorkersState();
}

class _SelectOrSearchWorkersState extends State<SelectOrSearchWorkers> {
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
    WorkersProvider wp = Provider.of<WorkersProvider>(context);
    asp = Provider.of<AppSettingsProvider>(context);

    return Column(
      children: [
        const SearchAndTranslateRowCompany(),
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
              child: SelectByIndustry(
                selectBy: 'Workers',
                getRecords: wp.getWorkersBySelection,
              ),
            ),
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
