import 'package:blukers/views/common_views/page_template/page_template.dart';
import 'package:flutter/material.dart';

import '../../../utils/styles/theme_text_styles.dart';
import 'manageSubscriptionComponents/active_subscription_card.dart';
import 'manageSubscriptionComponents/cancel_subscription_card.dart';
import 'manageSubscriptionComponents/payment_history_card.dart';
import 'manageSubscriptionComponents/upgrade_subscription_card.dart';

class ManagePaymentPage extends StatelessWidget {
  const ManagePaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      child: const SingleChildScrollView(
        child: Column(
          children: [
            Center(
                child: Padding(
              padding: EdgeInsets.all(15),
              child: Text('Manage Subscription Page',
                  style: ThemeTextStyles.headerThemeTextStyle),
            )),
            SizedBox(height: 20),
            ActiveSubscriptionCard(),
            SizedBox(height: 10),
            UpgradeSubscriptionCard(),
            SizedBox(height: 10),
            CancelSubscriptionCard(),
            SizedBox(height: 10),
            PaymentHistoryCard(),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
