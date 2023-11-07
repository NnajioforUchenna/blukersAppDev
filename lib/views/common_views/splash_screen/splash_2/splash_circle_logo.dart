import 'package:flutter/material.dart';

class SplashCircleLogo extends StatelessWidget {
  const SplashCircleLogo({super.key});

  @override
  Widget build(BuildContext context) {
    double size = 100.0; // Size of the circular container

    return Container(
      width: size,
      height: size,
      margin: const EdgeInsets.only(top: 70),
      decoration: const BoxDecoration(shape: BoxShape.circle),
      child: Image.asset(
        'assets/splash/circleLogo.png', // Replace with your asset name
        fit: BoxFit.cover, // Cover the entire widget space
        // You can add color filter or decoration as needed
      ),
    );
  }
}
