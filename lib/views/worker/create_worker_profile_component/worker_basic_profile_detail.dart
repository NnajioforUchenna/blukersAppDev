import 'package:blukers/utils/styles/theme_text_styles.dart';
import 'package:blukers/views/common_views/info_display_component.dart';
import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
        //   AppLocalizations.of(context)!.basicInformation,
        //   style:
        //       ThemeTextStyles.headingThemeTextStyle.apply(color: Colors.black),
        // ),
        // const SizedBox(
        //   height: 20,
        // ),
        InfoDisplayComponent(
          placeHolder: AppLocalizations.of(context)!.firstName,
          value: firstName,
        ),
        InfoDisplayComponent(
          placeHolder: AppLocalizations.of(context)!.middleName,
          value: middleName,
        ),
        InfoDisplayComponent(
          placeHolder: AppLocalizations.of(context)!.lastName,
          value: lastName,
        ),
        InfoDisplayComponent(
          placeHolder: AppLocalizations.of(context)!.description,
          value: description,
        ),
      ],
    );
  }
}
