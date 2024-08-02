import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

// USE:
// import 'package:blukers/views/common_views/components/animations/index.dart';
// MyAnimation(name: 'defaultAnimation'),

class MyAnimation extends StatelessWidget {
  final double width;
  final double height;
  final String name;

  const MyAnimation({super.key, 
    this.width = 150,
    this.height = 150,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    const Map<String, String> animationPaths = {
      'blukersLoadingDots': 'assets/animations/7PG5wnfHDZ.json',
      'loadingDots1': 'assets/animations/animation_lme8mh67.json',
      'loadingDots2': 'assets/animations/animation_lme8my5u.json',
      'loadingDots3': 'assets/animations/animation_lme8nbea.json',
      'loadingCircleLightBlue': 'assets/animations/animation_ll6sgldm.json',
      'loadingCircleBlue': 'assets/animations/animation_ll6szhsm.json',
      'circleCheckmarkBlue': 'assets/animations/animation_ll6st86s.json',
      'congratulationsCup': 'assets/animations/animation_ll6stgir.json',
      'greenCheckmark': 'assets/animations/animation_ll6stnmd.json',
      'congratulationsConfetti': 'assets/animations/animation_ll6su4li.json',
      'congratulationsConfettiBlue':
          'assets/animations/animation_ll6sz0it.json',
      'congratulationsConfettiBlue2':
          'assets/animations/animation_ll6sz5lm.json',
      'circlePulseBlue': 'assets/animations/animation_ll6sv0mu.json',
      'circlePulseBlue2': 'assets/animations/animation_ll6svq0n.json',
      'workerRegistration': 'assets/animations/animation_ll70pq2n.json',
      'defaultAnimation': 'assets/animations/animation_ll6svq0n.json',
    };

    final animationPath = animationPaths[name] ?? 'defaultAnimation';

    return Center(
      child: Lottie.asset(
        animationPath,
        width: width,
        height: height,
        fit: BoxFit.cover,
      ),
    );
  }
}
