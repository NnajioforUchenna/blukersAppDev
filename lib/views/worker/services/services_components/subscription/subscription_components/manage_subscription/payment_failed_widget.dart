import 'package:blukers/providers/user_provider_parts/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';


class PaymentFailedWidget extends StatelessWidget {
  const PaymentFailedWidget({super.key});

  @override

  Widget build(BuildContext context) {
    UserProvider up = Provider.of<UserProvider>(context);
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
        width: MediaQuery.of(context).size.width * 0.8,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.error_outline,
              size: 60.0,
              color: Colors.red,
            ),
            const SizedBox(height: 16.0),
            Text(
              AppLocalizations.of(context)!.paymentCancelledOrFailed,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              AppLocalizations.of(context)!.paymentCancelledOrFailedDescription,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
              final userRole = up.userRole;
              if (userRole == 'worker') {
                context.go('/workerOffers');
              } else if (userRole == 'company') {
                context.go('/companyOffers');
              }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                AppLocalizations.of(context)!.continueStr,
                style: const TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
