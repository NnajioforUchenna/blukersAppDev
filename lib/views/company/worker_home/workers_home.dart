import 'package:blukers/views/company/worker_home/worker_home_components/workers_desktop_view/workers_page_desktop.dart';
import 'package:blukers/views/company/worker_home/worker_home_components/workers_mobile_view/workers_page_mobile.dart';
import 'package:flutter/material.dart';

import '../../../services/responsive.dart';

class Workers extends StatelessWidget {
  const Workers({super.key});

  @override
  Widget build(BuildContext context) {
    return Responsive.isMobile(context)
        ? const WorkersPageMobile()
        : const WorkersPageDesktop();
  }
}
