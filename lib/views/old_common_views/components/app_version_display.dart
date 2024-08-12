import 'package:flutter/material.dart';

import '../../../utils/helpers/index.dart';
import '../../../utils/styles/index.dart';

class AppVersionDisplay extends StatelessWidget {
  const AppVersionDisplay({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          // height: double.infinity,
          alignment: Alignment.center, // This is needed
          padding: const EdgeInsets.all(3.0),
          child: Image.asset(
            "assets/images/logo.png",
            fit: BoxFit.contain,
            width: 35,
          ),
        ),
        Text(
          "VERSION " + AppVersionHelper().get(),
          style: const TextStyle(
            fontFamily: 'Montserrat',
            color: ThemeColors.grey2ThemeColor,
            fontSize: 12,
            height: 1.5,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    ));
  }
}
