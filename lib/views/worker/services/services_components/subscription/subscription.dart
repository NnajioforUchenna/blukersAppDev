import 'package:flutter/material.dart';

import '../../../../../services/responsive.dart';
import '../../../../common_vieiws/page_template/page_template.dart';
import 'subscription_components/mobile_view/subscription_mobile_view_widget.dart';
import 'subscription_components/web_view/desktop_membership_widget.dart';

class Subscription extends StatelessWidget {
  const Subscription({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      child: Responsive.isMobile(context)
          ? const MobileSubscriptionWidget()
          : const DesktopSubscriptionWidget(),
    );
  }
}
