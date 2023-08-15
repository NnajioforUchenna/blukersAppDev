import 'package:flutter/material.dart';

import 'desktop_membership_card.dart';

class DesktopCards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {},
            child: const DesktopMembershipCard(
              headerTitle: 'Free',
              headerSubtitle: '',
              amount: '\$0',
              period: '',
              features: ['', 'Create your Resume', 'Apply to 2 Jobs Daily'],
              color: Color(0xffF29500),
            ),
          ),
          InkWell(
            onTap: () {},
            child: const DesktopMembershipCard(
              headerTitle: 'Premium',
              headerSubtitle: '',
              amount: '\$4.99/',
              period: 'monthly',
              features: [
                'Create your Resume',
                'Upload your Resume',
                'Upload your Certifications',
                'Apply to 10 Jobs Daily',
                'Show your Profile on Top in Employers Searchers Section',
              ],
              color: Color(0xff1a75bb),
            ),
          ),
          InkWell(
            onTap: () {},
            child: const DesktopMembershipCard(
              headerTitle: 'Premium',
              headerSubtitle: 'Plus',
              amount: '\$19.99/',
              period: 'monthly',
              features: [
                'All Premium Feastures (*)',
                'Apply to Unlimited Jobs',
                'Display your immigration verified status so you can work internationally',
                'Get Employment Verfied',
              ],
              color: Color(0xffF16523),
            ),
          ),
        ],
      ),
    );
  }
}
