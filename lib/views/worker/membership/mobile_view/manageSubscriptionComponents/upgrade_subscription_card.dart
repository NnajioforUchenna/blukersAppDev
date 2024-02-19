import 'package:blukers/providers/payment_providers/payments_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class UpgradeSubscriptionCard extends StatelessWidget {
  const UpgradeSubscriptionCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PaymentsProvider pp = Provider.of<PaymentsProvider>(context);
    return Card(
      elevation: 8,
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Upgrade Your Subscription',
              style: GoogleFonts.montserrat(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Dreaming of working in the USA? 🇺🇸 By upgrading, you unlock unlimited opportunities to connect with top-tier companies that can bring your dream to life. Don\'t limit your aspirations. Go beyond boundaries, upgrade now!',
              style: GoogleFonts.montserrat(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              onPressed: () {
                // TODO: Add action for upgrade
                pp.upgradeSubscription(context);
              },
              child: Text(
                'UPGRADE NOW',
                style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
