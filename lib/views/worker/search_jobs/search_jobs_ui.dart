import 'package:blukers/services/responsive.dart';
import 'package:blukers/views/worker/search_jobs/search_job_ui_mobile.dart';
import 'package:blukers/views/worker/search_jobs/search_job_ui_web.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../providers/job_posts_provider.dart';
import '../../../utils/styles/theme_colors.dart';
import 'jobs_search_result_page/Components/job_pop_button_widget.dart';

class SearchJobsUi extends StatefulWidget {
  const SearchJobsUi({super.key});

  @override
  State<SearchJobsUi> createState() => _SearchJobsUiState();
}

class _SearchJobsUiState extends State<SearchJobsUi> {

  @override
  Widget build(BuildContext context) {
    return Responsive.isMobile(context)
        ? const SearchJobsUiMobile()
        : const SearchJobsUiWeb();
  }
}
