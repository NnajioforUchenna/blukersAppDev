import 'package:blukers/services/responsive.dart';
import 'package:blukers/views/worker/search_jobs/search_job_ui_mobile.dart';
import 'package:blukers/views/worker/search_jobs/search_job_ui_web.dart';
import 'package:flutter/material.dart';

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
