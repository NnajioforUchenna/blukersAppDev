import 'package:flutter/material.dart';

import '../../../../../services/responsive.dart';
import '../../../worker_page_template/worker_page_template.dart';
import 'subscription_components/mobile_view/subscription_mobile_view_widget.dart';
import 'subscription_components/web_view/desktop_membership_widget.dart';

class Subscription extends StatelessWidget {
  const Subscription({super.key});

  @override
  Widget build(BuildContext context) {
    return WorkerPageTemplate(
      child: Responsive.isMobile(context)
          ? const MobileSubscriptionWidget()
          : const DesktopSubscriptionWidget(),
    );
  }
}
