import 'package:flutter/material.dart';

import '../../../services/responsive.dart';
import 'job_home_components/jobs_desktop_view/jobs_page_desktop.dart';
import 'job_home_components/jobs_mobile_view/jobs_page_mobile.dart';

class Jobs extends StatelessWidget {
  const Jobs({super.key});

  @override
  Widget build(BuildContext context) {
    return Responsive.isMobile(context)
        ? const JobsPageMobile()
        : const JobsPageDesktop();
  }
}
