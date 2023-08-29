import 'package:flutter/material.dart';
import 'package:blukers/utils/styles/index.dart';
import 'package:blukers/utils/helpers/index.dart';
import 'package:unicons/unicons.dart';

class AppVersionDisplay extends StatelessWidget {
  AppVersionDisplay({
    super.key,
    // required this.icon,
    // required this.text,
    // this.color = ThemeColors.grey1ThemeColor,
  });

  // IconData icon;
  // String text;
  // Color color;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // const Icon(
        //   UniconsLine.info_circle,
        //   color: ThemeColors.grey1ThemeColor,
        //   size: 25,
        // ),
        Container(
          // height: double.infinity,
          alignment: Alignment.center, // This is needed
          child: Image.asset(
            "assets/images/logo.png",
            fit: BoxFit.contain,
            width: 60,
          ),
        ),
        Text(
          "v" + AppVersionHelper().get(),
          style: const TextStyle(
            fontFamily: 'Montserrat',
            color: ThemeColors.blukersOrangeThemeColor,
            fontSize: 14,
            height: 1.5,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    ));
  }
}
