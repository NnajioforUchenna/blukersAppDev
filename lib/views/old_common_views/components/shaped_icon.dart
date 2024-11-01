import '../../../utils/styles/index.dart';
import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

class ShapedIcon extends StatelessWidget {
  final String iconShape; // "none", "circle", ... later add: "square"
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;

  const ShapedIcon({
    super.key,
    this.iconShape = "none",
    this.icon = UniconsLine.smile,
    this.iconColor = Colors.white,
    this.backgroundColor = ThemeColors.black3ThemeColor,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      size: 15,
      color: ThemeColors.black3ThemeColor,
    );
    return CircleAvatar(
      radius: 20,
      backgroundColor: ThemeColors.black3ThemeColor,
      child: Icon(
        icon,
        size: 25,
        color: Colors.white,
      ),
    );
  }
}
