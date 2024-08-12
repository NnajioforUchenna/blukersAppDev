import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../old_common_views/info_display_component.dart';

class UserBasicProfileDetail extends StatelessWidget {
  const UserBasicProfileDetail(
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
        // Text(
        //   "Basic Information",
        //   style:
        //       ThemeTextStyles.headingThemeTextStyle.apply(color: Colors.black),
        // ),
        // const SizedBox(
        //   height: 20,
        // ),
        InfoDisplayComponent(
          placeHolder: AppLocalizations.of(context)!.displayName,
          value: displayName,
        ),
        InfoDisplayComponent(
          placeHolder: AppLocalizations.of(context)!.email,
          value: email,
        ),
        InfoDisplayComponent(
          placeHolder: AppLocalizations.of(context)!.phoneNumber,
          value: phoneNo,
        ),
        InfoDisplayComponent(
          placeHolder: AppLocalizations.of(context)!.language,
          value: language,
        ),
      ],
    );
  }
}
