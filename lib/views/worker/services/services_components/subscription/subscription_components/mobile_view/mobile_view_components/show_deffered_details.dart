import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../../../../common_files/constants.dart';
import '../../../../../../../../models/payment_model/subscription_model.dart';

class ShowDefferedDetails extends StatelessWidget {
  final SubscriptionPlan subscription;

  const ShowDefferedDetails({super.key, required this.subscription});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Text(
        AppLocalizations.of(context)!.planActivationMessage(
          formatDateTime(subscription.subscribeDate),
          subscription.subscriptionName,
        ),
        style: const TextStyle(
          fontSize: 14.0,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
