import 'package:blukers/providers/payment_providers/payments_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CancelSubscriptionDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called.
    PaymentsProvider pp = Provider.of<PaymentsProvider>(context);
    return AlertDialog(
      title: const Text('Cancel Subscription'),
      content: const SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text('Are you sure you want to cancel your subscription?'),
            SizedBox(height: 10),
            Text(
              'You will still have access to the current plan features until the end of your current billing period. After in which you will be downgraded to the free plan. The Basic Plan',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Cancel Subscription'),
          onPressed: () {
            // Handle subscription cancellation here
            Navigator.of(context).pop();
            Navigator.of(context).pop();
            Navigator.of(context).pop();
            pp.cancelSubscription(context);

            // You can also use this to pass data back to the caller widget
          },
        ),
        TextButton(
          child: const Text('Back'),
          onPressed: () {
            // Simply dismiss the dialog
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
