import 'package:blukers/services/responsive.dart';
import 'package:blukers/views/company/company_desktop_view/company_desktop_view.dart';
import 'package:blukers/views/company/company_mobile_view/company_mobile_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/app_settings_provider.dart';
import '../../providers/industry_provider.dart';
import '../../providers/worker_provider.dart';
import '../common_vieiws/page_template/page_template.dart';


class Workers extends StatelessWidget {
  const Workers({super.key});

  @override
  Widget build(BuildContext context) {
    IndustriesProvider ip = Provider.of<IndustriesProvider>(context);
    WorkerProvider wp = Provider.of<WorkerProvider>(context);
    AppSettingsProvider avp = Provider.of<AppSettingsProvider>(context);

    if (!kIsWeb) {
      avp.checkForUpdate(context);
    }

    return PageTemplate(
     child: Responsive.isMobile(context)
          ? const CompanyMobile()
          : const CompanyDesktop(),
    );
  }
}




























