import 'package:flutter/material.dart';

import '../../utils/styles/index.dart';
import '../old_common_views/components/animations/index.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.8,
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Transform.scale(
                scale:
                    2.0, // adjust the scale value to make it bigger or smaller
                child: const MyAnimation(
                  name: 'blukersLoadingDots',
                ),
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
      ),
    );
  }
}
