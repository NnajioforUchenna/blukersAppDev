import 'package:blukers/views/company/search_workers/worker_search_bar_components/worker_desktop_search_bar.dart';
import 'package:blukers/views/company/search_workers/worker_search_bar_components/worker_mobile_search_bar.dart';
import 'package:flutter/material.dart';

import '../../../../services/responsive.dart';

class WorkerAllSearchBar extends StatefulWidget {
  const WorkerAllSearchBar({super.key});

  @override
  State<WorkerAllSearchBar> createState() => _WorkerAllSearchBarState();
}

class _WorkerAllSearchBarState extends State<WorkerAllSearchBar> {
  @override
  Widget build(BuildContext context) {
    return const Responsive(
      mobile: WorkerMobileSearchBar(),
      desktop: WorkerDesktopSearchBar(),
    );
  }
}
