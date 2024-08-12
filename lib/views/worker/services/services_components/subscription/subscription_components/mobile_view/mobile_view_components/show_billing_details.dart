import 'package:blukers/common_files/constants.dart';
import 'package:blukers/models/payment_model/subscription_model.dart';
import 'package:flutter/material.dart';

class ShowBillingDetails extends StatelessWidget {
  final SubscriptionPlan subscription;

  const ShowBillingDetails({super.key, required this.subscription});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Text(
        'This subscription will expire on ${formatDateTime(subscription.renewDate)}.',
        style: const TextStyle(
          fontSize: 14.0,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
