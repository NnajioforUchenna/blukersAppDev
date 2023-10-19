import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../common_files/constants.dart';
import 'new_mobile_membership_card.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MobileNewMembershipWidget extends StatelessWidget {
  const MobileNewMembershipWidget({super.key});

  @override
  Widget build(BuildContext context) {
    String getTitle(title) {
      if (title.toString().toLowerCase() == "basic") {
        return AppLocalizations.of(context)!.basic;
      }
      return title;
    }

    double height = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: height * 0.05, bottom: height * 0.1),
          child: Text(
            AppLocalizations.of(context)!.subscriptions,
            style: GoogleFonts.montserrat(
                fontWeight: FontWeight.bold, fontSize: 24),
          ),
        ),
        Column(
          children: [
            for (var subscription in listSubscriptions)
              NewMobileMembershipCard(
                color: subscription['color'],
                title: getTitle(subscription['title']),
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
