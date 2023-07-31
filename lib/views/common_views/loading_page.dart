import 'package:bulkers/utils/styles/index.dart';
import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Transform.scale(
              scale: 2.0, // adjust the scale value to make it bigger or smaller
              child: const CircularProgressIndicator(
                strokeWidth: 5,
                valueColor: AlwaysStoppedAnimation<Color>(
                    ThemeColors.primaryThemeColor),
              ),
            ),
            const SizedBox(height: 50), // space between progress bar and text
            const Text(
              'Loading...',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: ThemeColors.secondaryThemeColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
