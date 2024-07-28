import 'package:blukers/views/worker/jobs_home/Components/jobs_desktop_view/jobs_page_desktop.dart';
import 'package:blukers/views/worker/jobs_home/Components/jobs_mobile_view/jobs_page_mobile.dart';
import 'package:flutter/material.dart';

import '../../../services/responsive.dart';

class Jobs extends StatelessWidget {
  const Jobs({super.key});

  @override
  Widget build(BuildContext context) {
    return Responsive.isMobile(context)
        ? const JobsPageMobile()
        : const JobsPageDesktop();
  }
}
