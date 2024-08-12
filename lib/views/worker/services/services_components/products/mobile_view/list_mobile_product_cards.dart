import 'dart:ui';

import '../../subscription/subscription_components/mobile_view/mobile_view_components/mobile_subscription_card.dart';

const List<MobileMembershipCard> productsCards = [
  MobileMembershipCard(
    headerTitle: 'FOIA',
    headerSubtitle: '',
    bodyTitle: 'Get Your FOIA Report',
    bodySubtitle:
        'Know What the Government Knows About You. You will receive your FOIA results by mail.',
    color: Color(0xffF16523),
    isNormalArrangement: true,
  ),
  MobileMembershipCard(
    headerTitle: 'Employment',
    headerSubtitle: 'Verification',
    bodyTitle: 'Get Employment verified',
    bodySubtitle:
        'We will verify that you are a trusted candidate. You will receive your employment verification certificate by mail.',
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
