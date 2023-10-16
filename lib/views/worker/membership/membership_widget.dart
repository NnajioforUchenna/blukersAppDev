import 'package:blukers/views/common_views/page_template/page_template.dart';
import 'package:flutter/material.dart';

import '../../../services/responsive.dart';
import 'new_mobile_view/mobile_new_membership_widget.dart';
import 'web_view/desktop_membership_widget.dart';

class MembershipWidget extends StatelessWidget {
  const MembershipWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      child: Responsive.isMobile(context)
          ? const MobileNewMembershipWidget()
          : const DesktopMembershipWidget(),
    );
  }
}
