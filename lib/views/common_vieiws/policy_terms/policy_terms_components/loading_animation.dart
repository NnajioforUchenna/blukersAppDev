import 'package:flutter/material.dart';

import '../../../../utils/styles/index.dart';
import '../../../old_common_views/components/animations/index.dart';

class LoadingAnimation extends StatelessWidget {
  final double width;
  final double height;
  final String text;

  const LoadingAnimation({
    super.key,
    this.width = 250,
    this.height = 250,
    this.text = '',
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MyAnimation(
              name: 'blukersLoadingDots',
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
      ),
    );
  }
}
