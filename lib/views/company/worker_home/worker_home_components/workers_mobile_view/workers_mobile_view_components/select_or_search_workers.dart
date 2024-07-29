import 'package:blukers/views/company/worker_home/worker_home_components/workers_mobile_view/workers_mobile_view_components/search_and_translate_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../../../../../providers/app_settings_provider.dart';
import '../../../../../../providers/industry_provider.dart';
import '../../../../../../utils/styles/theme_colors.dart';
import '../../../../../common_vieiws/loading_page.dart';
import '../../../../../worker/jobs_home/job_home_components/jobs_mobile_view/jobs_mobile_view_compnents/mobile_industry_headpanel.dart';

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
    asp = Provider.of<AppSettingsProvider>(context);

    return Column(
      children: [
        const SearchAndTranslateRowCompany(),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 30.0),
          child: Text(AppLocalizations.of(context)!.selectAnIndustry,
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                fontSize: 22.0,
                fontWeight: FontWeight.w700,
                color: ThemeColors.secondaryThemeColor,
              )),
        ),
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
                  children: ip.industries.values.map((industry) {
                    return Container(
                      margin: const EdgeInsets.only(
                          bottom: 10.0, left: 30, right: 30),
                      child: MobileIndustryHeadPanel(industry: industry),
                    );
                  }).toList(),
                ),
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
