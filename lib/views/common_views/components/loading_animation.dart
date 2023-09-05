import 'package:flutter/material.dart';
import 'package:blukers/utils/styles/index.dart';
import './animations/index.dart';

// USE:
// import 'package:blukers/views/common_views/components/loading_animation.dart';
// LoadingAnimation(text: 'Loading'),

class LoadingAnimation extends StatelessWidget {
  final double width;
  final double height;
  final String text;

  LoadingAnimation({
    this.width = 150,
    this.height = 150,
    this.text = '',
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          MyAnimation(
            name: 'circlePulseBlue',
            width: width,
            height: height,
          ),
          Text(
            text,
            style: ThemeTextStyles.headingThemeTextStyle.apply(
              color: ThemeColors.grey1ThemeColor,
            ),
          )
        ],
      ),
    );
  }
}
