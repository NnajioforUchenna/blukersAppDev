import 'package:blukers/views/worker/worker_home/worker_home_components/jobs_desktop_view/jobs_page_desktop.dart';
import 'package:blukers/views/worker/worker_home/worker_home_components/jobs_mobile_view/jobs_page_mobile.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/app_settings_provider.dart';
import '../../../services/responsive.dart';
import '../../common_vieiws/page_template/page_template.dart';

class Jobs extends StatelessWidget {
  const Jobs({super.key});

  @override
  Widget build(BuildContext context) {
    AppSettingsProvider avp = Provider.of<AppSettingsProvider>(context);
    if (!kIsWeb) {
      avp.checkForUpdate(context);
    }

    return PageTemplate(
      child: Responsive.isMobile(context)
          ? const JobsPageMobile()
          : const JobsPageDesktop(),
    );
  }
}
