import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PaymentSuccessfulWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.green.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        width: MediaQuery.of(context).size.width * 0.8,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.check_circle_outline,
              size: 60.0,
              color: Colors.green,
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Payment Successful',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Thank you for your payment. Your transaction has been completed successfully.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Navigate to Jobs page
                context.go('/jobs');
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: const Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}
