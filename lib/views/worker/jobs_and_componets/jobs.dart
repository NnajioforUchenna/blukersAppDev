import 'package:blukers/providers/app_versions_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../services/responsive.dart';
import '../../common_views/page_template/page_template.dart';
import 'jobs_desktop_view/jobs_page_desktop.dart';
import 'jobs_mobile_view/jobs_page_mobile.dart';

class Jobs extends StatelessWidget {
  const Jobs({super.key});

  @override
  Widget build(BuildContext context) {
    AppVersionsProvider avp = Provider.of<AppVersionsProvider>(context);
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
