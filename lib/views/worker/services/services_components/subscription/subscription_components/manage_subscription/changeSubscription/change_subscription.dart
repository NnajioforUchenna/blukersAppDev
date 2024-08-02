import 'package:blukers/providers/payment_providers/payments_provider.dart';
import 'package:blukers/views/worker/services/services_components/subscription/subscription_components/manage_subscription/changeSubscription/change_subscription_button.dart';
import 'package:blukers/views/worker/services/services_components/subscription/subscription_components/manage_subscription/changeSubscription/upgrade_subscription_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'cancel_subscription_dialog.dart';
import 'downgrade_subscription_dialog.dart';

class ChangeSubscription extends StatelessWidget {
  const ChangeSubscription({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    PaymentsProvider pp = Provider.of<PaymentsProvider>(context);
    return Container(
      margin: EdgeInsets.symmetric(vertical: height * 0.12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ChangeSubscriptionButton(
              title: "Upgrade",
              color: Colors.blueAccent,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const UpgradeSubscriptionDialog();
                  },
                );
              }),
          ChangeSubscriptionButton(
              title: "Downgrade",
              color: Colors.orange,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const DowngradeSubscriptionDialog();
                  },
                );
              }),
          ChangeSubscriptionButton(
              title: "Cancel",
              color: Colors.red,
              onTap: () {
                showDialog<void>(
                  context: context,
                  barrierDismissible: false,
                  // User must tap button to close the dialog
                  builder: (BuildContext context) {
                    return const CancelSubscriptionDialog();
                  },
                );
              })
        ],
      ),
    );
  }
}
