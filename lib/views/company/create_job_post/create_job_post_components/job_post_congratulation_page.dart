import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../providers/user_provider_parts/user_provider.dart';

class JobPostCongratulationPage extends StatefulWidget {
  const JobPostCongratulationPage({super.key});

  @override
  State<JobPostCongratulationPage> createState() =>
      _JobPostCongratulationPageState();
}

class _JobPostCongratulationPageState extends State<JobPostCongratulationPage> {
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
      context.go('/myJobPosts');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Icon(Icons.check_circle, color: Colors.green, size: 100),
        const SizedBox(height: 20),
        const Text(
          'Congratulations!',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const Text('You have successfully created New Job Post.'),
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
                    fontWeight: FontWeight
                        .bold), // Increased font size for countdown value
              ),
              const TextSpan(text: ' seconds...'),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
