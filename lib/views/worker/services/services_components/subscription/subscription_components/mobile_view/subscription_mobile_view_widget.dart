import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../../../../common_files/constants.dart';
import '../../../../../../../providers/user_provider_parts/user_provider.dart';
import 'mobile_view_components/new_mobile_subscription_card.dart';
import 'mobile_view_components/show_billing_details.dart';
import 'mobile_view_components/show_deffered_details.dart';

class MobileSubscriptionWidget extends StatelessWidget {
  const MobileSubscriptionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    String getTitle(title) {
      if (title.toString().toLowerCase() == "basic") {
        return AppLocalizations.of(context)!.basic;
      }
      return title;
    }

    double height = MediaQuery.of(context).size.height;
    UserProvider up = Provider.of<UserProvider>(context);
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
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                if (up.appUser != null &&
                    up.appUser?.deferredSubscription != null)
                  ShowDefferedDetails(
                    subscription: up.appUser!.deferredSubscription!,
                  ),
                const SizedBox(height: 10),
                for (var subscription in listSubscriptions)
                  MobileSubscriptionCard(
                    color: subscription['color'],
                    title: getTitle(subscription['title']),
                    subtitle: subscription['subtitle'],
                    amount: subscription['amount'],
                    subscriptionId: subscription['subscriptionId'],
                    details: subscription['details'],
                    description: subscription['description'],
                    moreIconColor: subscription['more_icon_color'],
                    buttonText: subscription['upgrade_button_text'],
                  ),
                const SizedBox(height: 10),
                if (up.appUser != null &&
                    up.appUser?.activeSubscription != null)
                  ShowBillingDetails(
                    subscription: up.appUser!.activeSubscription!,
                  ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
