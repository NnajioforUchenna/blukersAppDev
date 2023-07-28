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

  static TextStyle headerThemeTextStyle = TextStyle(
    fontFamily: 'Montserrat',
    color: ThemeColors.black1ThemeColor,
    fontSize: 40,
    height: 0.5,
    fontWeight: FontWeight.w600,
  );

  static TextStyle bodyThemeTextStyle = TextStyle(
    fontFamily: 'Montserrat',
    color: ThemeColors.black1ThemeColor,
    fontSize: 10,
    height: 0.5,
    fontWeight: FontWeight.w400,
  );

  static TextStyle bottomNavThemeTextStyle = TextStyle(
    fontFamily: 'Montserrat',
    color: ThemeColors.black1ThemeColor,
    fontSize: 10,
    height: 0.5,
    fontWeight: FontWeight.w400,
  );
}
