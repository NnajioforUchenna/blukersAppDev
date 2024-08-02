import 'package:flutter/material.dart';

import '../../../../services/responsive.dart';
import 'job_desktop_search_bar.dart';
import 'job_mobile_search_bar.dart';

class JobAllSearchBar extends StatefulWidget {
  const JobAllSearchBar({super.key});

  @override
  State<JobAllSearchBar> createState() => _JobAllSearchBarState();
}

class _JobAllSearchBarState extends State<JobAllSearchBar> {
  @override
  Widget build(BuildContext context) {
    return const Responsive(
      mobile: JobMobileSearchBar(),
      desktop: JobDesktopSearchBar(),
    );
  }
}
