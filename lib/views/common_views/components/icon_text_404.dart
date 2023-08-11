import 'package:flutter/material.dart';
import 'package:bulkers/utils/styles/index.dart';

class IconText404 extends StatelessWidget {
  IconText404({
    super.key,
    required this.icon,
    required this.text,
    this.color = ThemeColors.grey1ThemeColor,
  });

  IconData icon;
  String text;
  Color color;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon, color: ThemeColors.grey1ThemeColor, size: 50),
        Text(
          text,
          style: const TextStyle(
            fontFamily: 'Montserrat',
            color: ThemeColors.grey1ThemeColor,
            fontSize: 20,
            height: 1.5,
            fontWeight: FontWeight.w600,
          ),
        )
      ],
    ));
  }
}
