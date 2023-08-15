import 'dart:ui';

import 'mobile_membership_card.dart';

// Color(0xffF29500)

const List<MobileMembershipCard> memberShipCards = [
  MobileMembershipCard(
    headerTitle: 'Premium',
    headerSubtitle: '',
    bodyTitle: '10 Jobs Daily',
    bodySubtitle: 'Apply to',
    color: Color(0xffF16523),
    isNormalArrangement: false,
  ),
  MobileMembershipCard(
    headerTitle: 'Premium',
    headerSubtitle: '',
    bodyTitle: 'Show your Profile on Top',
    bodySubtitle: 'in employers searchers section',
    color: Color(0xff1a75bb),
    isNormalArrangement: true,
  ),
  MobileMembershipCard(
    headerTitle: 'Premium',
    headerSubtitle: 'Plus',
    bodyTitle: 'Display your Immigration verified Status',
    bodySubtitle: 'so you can work internationally',
    color: Color(0xffF16523),
    isNormalArrangement: true,
  ),
  MobileMembershipCard(
    headerTitle: 'Premium',
    headerSubtitle: 'Plus',
    bodyTitle: 'Get Employment verified',
    bodySubtitle: '',
    color: Color(0xff1a75bb),
    isNormalArrangement: true,
  ),
];
