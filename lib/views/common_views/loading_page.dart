import 'package:blukers/utils/styles/index.dart';
import 'package:flutter/material.dart';

import 'components/animations/index.dart';
import 'package:blukers/views/common_views/components/loading_animation.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Transform.scale(
              scale: 2.0, // adjust the scale value to make it bigger or smaller
              child: MyAnimation(
                name: 'blukersLoadingDots',
              ),
              // child: LoadingAnimation(),
            ),
            const SizedBox(height: 25), // space between progress bar and text
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
