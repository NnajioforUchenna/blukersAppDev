import 'package:flutter/material.dart';

import '../../services/responsive.dart';
import 'mobile_view/mobile_membership_widget.dart';
import 'web_view/desktop_membership_widget.dart';

class MembershipWidget extends StatelessWidget {
  const MembershipWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Responsive.isMobile(context)
        ? const MobileMembershipWidget()
        : const DesktopMembershipWidget();
  }
}
