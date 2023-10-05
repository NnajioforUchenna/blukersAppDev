import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../common_files/constants.dart';
import 'new_mobile_membership_card.dart';

class MobileNewMembershipWidget extends StatelessWidget {
  const MobileNewMembershipWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: height * 0.05, bottom: height * 0.1),
          child: Text(
            'Subscriptions',
            style: GoogleFonts.montserrat(
                fontWeight: FontWeight.bold, fontSize: 24),
          ),
        ),
        Column(
          children: [
            for (var subscription in listSubscriptions)
              NewMobileMembershipCard(
                color: subscription['color'],
                title: subscription['title'],
                subtitle: subscription['subtitle'],
                amount: subscription['amount'],
                subscriptionId: subscription['subscriptionId'],
                details: subscription['details'],
              ),
          ],
        )
      ],
    );
  }
}
