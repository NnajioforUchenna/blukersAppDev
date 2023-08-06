import 'package:bulkers/utils/styles/theme_text_styles.dart';
import 'package:bulkers/views/common_views/info_display_component.dart';
import 'package:flutter/material.dart';

class BasicProfileDetail extends StatelessWidget {
  const BasicProfileDetail(
      {super.key,
      required this.displayName,
      required this.email,
      required this.phoneNo,
      required this.language});
  final String displayName;
  final String email;
  final String phoneNo;
  final String language;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Basic Information",
          style:
              ThemeTextStyles.headingThemeTextStyle.apply(color: Colors.black),
        ),
        const SizedBox(
          height: 20,
        ),
        InfoDisplayComponent(
          placeHolder: "Display Name",
          value: displayName,
        ),
        InfoDisplayComponent(
          placeHolder: "Email",
          value: email,
        ),
        InfoDisplayComponent(
          placeHolder: "Phone No",
          value: phoneNo,
        ),
        InfoDisplayComponent(
          placeHolder: "language",
          value: language,
        ),
      ],
    );
  }
}
