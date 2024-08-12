import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../providers/user_provider_parts/user_provider.dart';

class CompanyCongratulationPage extends StatefulWidget {
  const CompanyCongratulationPage({super.key});

  @override
  State<CompanyCongratulationPage> createState() =>
      _CompanyCongratulationPageState();
}

class _CompanyCongratulationPageState extends State<CompanyCongratulationPage> {
  int countdownValue = 5;
  late Timer _timer;
  late UserProvider up;

  @override
  void initState() {
    super.initState();
    up = Provider.of<UserProvider>(context, listen: false);
    _startCountdown();
    _navigateAfterDelay();
  }

  _startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (countdownValue > 0) {
          countdownValue--;
        } else {
          _timer.cancel();
        }
      });
    });
  }

  _navigateAfterDelay() {
    Future.delayed(Duration(seconds: countdownValue), () {
      _timer.cancel();
      context.go('/workers');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Icon(Icons.check_circle, color: Colors.green, size: 100),
            const SizedBox(height: 20),
            Text(
              AppLocalizations.of(context)!.congratulations,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(AppLocalizations.of(context)!
                .youHaveSuccessfullyCreatedYourCompanyProfile),
            const SizedBox(height: 20),
            Text.rich(
              TextSpan(
                text: 'Navigating in ',
                style: const TextStyle(fontSize: 20),
                children: <TextSpan>[
                  TextSpan(
                    text: '$countdownValue',
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ), // Increased font size for countdown value
                  ),
                  const TextSpan(text: ' seconds...'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
