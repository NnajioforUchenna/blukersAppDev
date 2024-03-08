import 'package:blukers/providers/payment_providers/payments_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DowngradeSubscriptionDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PaymentsProvider pp = Provider.of<PaymentsProvider>(context);
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text(
              'Downgrade Subscription',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Do you want to downgrade?',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10.0),
            const Text(
              'If you downgrade, Your current subscription "Premium Plus" will end in the next billing cycle. You will be charged for the "Premium" subscription now for no interruption during the swap period, but it will begin in the next billing cycle.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    // Perform action to confirm downgrade
                    Navigator.of(context).pop();
                    pp.downgradeSubscription(context);
                  },
                  child: const Text('Confirm'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: const Text('Cancel'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
