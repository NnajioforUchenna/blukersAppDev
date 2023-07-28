import 'package:flutter/material.dart';
import '../../utils/styles/index.dart';

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
              child: CircularProgressIndicator(
                strokeWidth: 5,
                valueColor: AlwaysStoppedAnimation<Color>(ThemeColors.primaryThemeColor),
              ),
            ),
            SizedBox(height: 50), // space between progress bar and text
            Text(
              'Getting Records from Database...',
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
