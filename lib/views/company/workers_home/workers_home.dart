import 'package:flutter/material.dart';

import '../../../services/responsive.dart';
import 'worker_home_desktop/workers_home_desktop.dart';
import 'worker_home_mobile/workers_home_mobile.dart';

class Workers extends StatelessWidget {
  const Workers({super.key});

  @override
  Widget build(BuildContext context) {
    return Responsive.isMobile(context)
        ? const WorkersHomeMobile()
        : const WorkersHomeDesktop();
  }
}
