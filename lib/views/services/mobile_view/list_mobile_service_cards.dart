import 'dart:ui';

import '../../membership/mobile_view/mobile_membership_card.dart';

const List<MobileMembershipCard> servicesCards = [
  MobileMembershipCard(
    headerTitle: 'FOIA',
    headerSubtitle: '',
    bodyTitle: 'Get Your FOIA Report',
    bodySubtitle: 'Know What the Government Knows About You',
    color: Color(0xffF16523),
    isNormalArrangement: true,
  ),
  MobileMembershipCard(
    headerTitle: 'Employment',
    headerSubtitle: 'Verification',
    bodyTitle: 'Get Employment verified',
    bodySubtitle: 'Let employers know you are a trusted candidate',
    color: Color(0xff1a75bb),
    isNormalArrangement: true,
  ),
];

const List<MobileMembershipCard> backServicesCards = [
  MobileMembershipCard(
    headerTitle: '',
    headerSubtitle: '',
    bodyTitle: '',
    bodySubtitle: '',
    color: Color(0xffF16523),
    isNormalArrangement: false,
  ),
  MobileMembershipCard(
    headerTitle: '',
    headerSubtitle: '',
    bodyTitle: '',
    bodySubtitle: '',
    color: Color(0xff1a75bb),
    isNormalArrangement: true,
  ),
];
