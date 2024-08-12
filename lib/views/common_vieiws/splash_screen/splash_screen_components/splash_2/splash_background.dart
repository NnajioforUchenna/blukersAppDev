import 'package:flutter/material.dart';

class SplashBackground extends StatelessWidget {
  const SplashBackground({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.9;
    double height = MediaQuery.of(context).size.height * 0.8;
    return Container(
      height: height,
      width: width,
      margin: const EdgeInsets.only(top: 55, left: 25, right: 25),
      decoration: BoxDecoration(
        // Add rounded corners
        borderRadius: BorderRadius.circular(60), // Adjust the radius as needed
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(60),
        child: SizedBox.fromSize(
          size: const Size.fromRadius(60),
          child: Image.asset(
            'assets/splash/splashBackground.png', // Replace with your asset name
            fit: BoxFit.fill, // Cover the entire widget space
            // You can add color filter or decoration as needed
          ),
        ),
      ),
    );
  }
}
