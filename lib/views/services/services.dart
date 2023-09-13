import 'package:blukers/views/services/mobile_view/mobile_services_widget.dart';
import 'package:flutter/material.dart';

import '../../services/responsive.dart';
import 'web_view/desktop_services_widget.dart';

class Services extends StatelessWidget {
  const Services({super.key});

  @override
  Widget build(BuildContext context) {
    return Responsive.isMobile(context)
        ? const MobileServicesWidget()
        : const DesktopServicesWidget();
  }
}
