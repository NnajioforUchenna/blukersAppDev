import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../providers/user_provider_parts/user_provider.dart';
import '../../../../utils/styles/index.dart';
import '../../../old_common_views/components/animations/index.dart';
// import 'package:blukers/views/auth/common_widget/submit_button.dart';

class RegistrationCongratulationPage extends StatefulWidget {
  const RegistrationCongratulationPage({super.key});

  @override
  State<RegistrationCongratulationPage> createState() =>
      _RegistrationCongratulationPageState();
}

class _RegistrationCongratulationPageState
    extends State<RegistrationCongratulationPage> {
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
      _timer.cancel(); // Cancel the timer if it's still active
      if (up.userRole == "worker") {
        context.go('/jobs');
      } else {
        context.go('/workers');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          // const Icon(Icons.check_circle, color: Colors.green, size: 100),
          const MyAnimation(
            name: 'congratulationsConfetti',
            width: 300,
            height: 300,
          ),
          const SizedBox(height: 10),
          Text(
            AppLocalizations.of(context)!.congratulations,
            style: const TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              fontFamily: 'Montserrat',
              color: ThemeColors.secondaryThemeColor,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            AppLocalizations.of(context)!.youHaveSuccessfullySignedUp,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'Montserrat',
              color: ThemeColors.grey1ThemeColor,
            ),
          ),
          const SizedBox(height: 20),
          Text.rich(
            TextSpan(
              text: 'Wait/Espere ',
              style: const TextStyle(
                  fontSize: 16,
                  color: ThemeColors.primaryThemeColor,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold),
              children: <TextSpan>[
                TextSpan(
                  text: '$countdownValue',
                  style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight
                          .bold), // Increased font size for countdown value
                ),
                const TextSpan(text: '...'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
