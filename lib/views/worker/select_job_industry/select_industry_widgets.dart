import 'package:blukers/utils/styles/theme_colors.dart';
import 'package:blukers/views/worker/select_job_industry/widgets/industry_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

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
  Widget build(BuildContext context) {
    IndustriesProvider ip = Provider.of<IndustriesProvider>(context);
    JobPostsProvider jp = Provider.of<JobPostsProvider>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SearchHeaderMobile(),
        Expanded(
          child: AnimatedCrossFade(
            firstChild: const LoadingPage(),
            secondChild: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 30.0),
                    child:
                        Text(AppLocalizations.of(context)!.selectJobsAnIndustry,
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
