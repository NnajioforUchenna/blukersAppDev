import 'package:flutter/material.dart';
import './theme_colors.dart';

abstract class ThemeTextStyles {
  // GENERIC

  static const TextStyle appBarThemeTextStyle = TextStyle(
    fontFamily: 'Montserrat',
    color: ThemeColors.primaryThemeColor,
    fontSize: 16,
    height: 0.5,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle headerThemeTextStyle = TextStyle(
    fontFamily: 'Montserrat',
    color: ThemeColors.secondaryThemeColor,
    fontSize: 30,
    height: 1.5,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle bodyThemeTextStyle = TextStyle(
    fontFamily: 'Montserrat',
    color: ThemeColors.black1ThemeColor,
    fontSize: 16,
    height: 1.0,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle bottomNavThemeTextStyle = TextStyle(
    fontFamily: 'Montserrat',
    color: ThemeColors.black1ThemeColor,
    fontSize: 10,
    height: 0.5,
    fontWeight: FontWeight.w400,
  );

  // LANDING PAGE

  static const TextStyle landingPageSubtitleThemeTextStyle = TextStyle(
    fontFamily: 'Montserrat',
    color: ThemeColors.primaryThemeColor,
    fontSize: 26,
    height: 1.2,
    fontWeight: FontWeight.w800,
  );

  static const TextStyle landingPageQuestionThemeTextStyle = TextStyle(
    fontFamily: 'Montserrat',
    color: ThemeColors.secondaryThemeColor,
    fontSize: 22,
    height: 0.5,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle landingPageBtnThemeTextStyle = TextStyle(
    fontFamily: 'Montserrat',
    color: ThemeColors.primaryThemeColor,
    fontSize: 16,
    height: 0.5,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle headingThemeTextStyle = TextStyle(
    fontFamily: 'Montserrat',
    color: ThemeColors.secondaryThemeColor,
    fontSize: 20,
    height: 1.5,
    fontWeight: FontWeight.w700,
  );
  static const TextStyle informationDisplayPlaceHolderThemeTextStyle =
      TextStyle(
    fontFamily: 'Montserrat',
    color: ThemeColors.black1ThemeColor,
    fontSize: 16,
    height: 1.0,
    fontWeight: FontWeight.w600,
  );
}
