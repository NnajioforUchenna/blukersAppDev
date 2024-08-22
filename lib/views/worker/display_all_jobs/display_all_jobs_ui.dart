import 'package:blukers/providers/jobs_lists_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'all_jobs_list_view.dart';

class DisplayAllJobsUi extends StatefulWidget {
  const DisplayAllJobsUi({super.key});

  @override
  State<DisplayAllJobsUi> createState() => _DisplayAllJobsUiState();
}

class _DisplayAllJobsUiState extends State<DisplayAllJobsUi> {
  @override
  Widget build(BuildContext context) {
    JobsListsProvider jb = Provider.of<JobsListsProvider>(context);
    return const Column(
      children: [Expanded(child: AllJobsListView())],
    );
  }
}
