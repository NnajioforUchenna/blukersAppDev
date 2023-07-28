import 'package:flutter/material.dart';
import './theme_colors.dart';

abstract class ThemeTextStyles {
  static TextStyle appBarThemeTextStyle = TextStyle(
    fontFamily: 'Montserrat',
    color: ThemeColors.primaryThemeColor,
    fontSize: 16,
    height: 0.5,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle headerThemeTextStyle = TextStyle(
    fontFamily: 'Montserrat',
    color: ThemeColors.black1,
    fontSize: 40,
    height: 0.5,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle bodyThemeTextStyle = TextStyle(
    fontFamily: 'Montserrat',
    color: ThemeColors.black1,
    fontSize: 10,
    height: 0.5,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle bottomNavThemeTextStyle = TextStyle(
    fontFamily: 'Montserrat',
    color: ThemeColors.black1,
    fontSize: 10,
    height: 0.5,
    fontWeight: FontWeight.w400,
  );
}
