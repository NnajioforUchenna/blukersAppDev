import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../common_files/constants.dart';
import '../../providers/user_provider_parts/user_provider.dart';

class JobPostEligibilityDialog extends StatelessWidget {
  const JobPostEligibilityDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    UserProvider up = Provider.of<UserProvider>(context);
    String subscriptionType =
        up.appUser?.activeSubscription?.subscriptionId ?? '';
    String numberOfJobsAppliedToday = up
            .appUser?.jobApplicationTracker?.numberOfAppliedJobsToday
            .toString() ??
        '0';

    return Center(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2.5,
              blurRadius: 3.5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        width: width * 0.8,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.info_outline,
              size: 60.0,
              color: Colors.redAccent,
            ),
            const SizedBox(height: 16.0),
            Text(
              "Your Active Subscription:  ${ProductNames[subscriptionType]}",
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10.0),
            Text(
              "You've applied for $numberOfJobsAppliedToday jobs today.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 10.0),
            const Text(
              "Based on your current subscription, you can't apply for more jobs today.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.redAccent,
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Logic for button press
                context.go('/managePayment');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Upgrade Subscription',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
