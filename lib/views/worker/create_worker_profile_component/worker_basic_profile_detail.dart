import 'package:blukers/utils/styles/theme_text_styles.dart';
import 'package:blukers/views/common_views/info_display_component.dart';
import 'package:flutter/material.dart';

class WorkerBasicProfileDetail extends StatelessWidget {
  const WorkerBasicProfileDetail(
      {super.key,
      required this.firstName,
      required this.lastName,
      required this.middleName,
      required this.description});
  final String firstName;
  final String lastName;
  final String middleName;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Text(
        //   "Basic Information",
        //   style:
        //       ThemeTextStyles.headingThemeTextStyle.apply(color: Colors.black),
        // ),
        // const SizedBox(
        //   height: 20,
        // ),
        InfoDisplayComponent(
          placeHolder: "First Name",
          value: firstName,
        ),
        InfoDisplayComponent(
          placeHolder: "Middle Name",
          value: middleName,
        ),
        InfoDisplayComponent(
          placeHolder: "last Name",
          value: lastName,
        ),
        InfoDisplayComponent(
          placeHolder: "Description",
          value: description,
        ),
      ],
    );
  }
}
