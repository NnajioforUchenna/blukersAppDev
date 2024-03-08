import 'splash_circle_logo.dart';
import 'package:flutter/material.dart';

import '../../../../../common_files/constants.dart';
import 'bottom_left_text.dart';
import 'bottom_right_text.dart';
import 'left_character.dart';
import 'right_character.dart';
import 'splash_background.dart';
import 'top_left_text.dart';
import 'top_right_text.dart';

class SplashScreenPage2 extends StatelessWidget {
  final String topRightText;
  final String topLeftText;
  final String bottomRightText;
  final String bottomLeftText;
  final String leftImage;
  final String rightImage;

  const SplashScreenPage2(
      {super.key,
      required this.topRightText,
      required this.topLeftText,
      required this.bottomRightText,
      required this.bottomLeftText,
      required this.leftImage,
      required this.rightImage});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        const SplashBackground(),
        const SplashCircleLogo(),
        LeftCharacter(
          imageUrl: leftImage,
        ),
        RightCharacter(imageUrl: rightImage),
        TopLeftText(
          title: getFirstWord(topLeftText),
          subtitle: removeFirstWord(topLeftText),
        ),
        TopRightText(
          title: getFirstWord(topRightText),
          subtitle: removeFirstWord(topRightText),
        ),
        BottomLeftText(
          title: getFirstWord(bottomLeftText),
          subtitle: removeFirstWord(bottomLeftText),
        ),
        BottomRightText(
          title: getFirstWord(bottomRightText),
          subtitle: removeFirstWord(bottomRightText),
        )
      ],
    );
  }
}
