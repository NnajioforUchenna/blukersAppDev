import 'package:flutter/material.dart';

import '../../../services/responsive.dart';
import 'new_mobile_view/mobile_new_membership_widget.dart';
import 'web_view/desktop_membership_widget.dart';

class MembershipWidget extends StatelessWidget {
  const MembershipWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Responsive.isMobile(context)
        ? const MobileNewMembershipWidget()
        : const DesktopMembershipWidget();
  }
}
