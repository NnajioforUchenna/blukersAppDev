import 'package:blukers/providers/payment_providers/payments_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpgradeSubscriptionDialog extends StatelessWidget {
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
              'Upgrade Subscription',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Ready for more features?',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10.0),
            const Text(
              'By upgrading to "Premium Plus", you get immediate access to exclusive features not available on the Premium plan. The price difference for the remaining period of your current plan will be charged now, ensuring a smooth transition without any interruption to your service. Your billing cycle remains the same.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    // Perform action to confirm upgrade
                    Navigator.of(context).pop();
                    pp.upgradeSubscription(context);
                  },
                  child: const Text('Upgrade'),
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
