import 'package:blukers/views/worker/profile/profile_rows/profile_row_four/basic_user_information.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../profile_menu_button.dart';

class ProfileRowFour extends StatelessWidget {
  const ProfileRowFour({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfileMenuButton(
      text: AppLocalizations.of(context)!.userInformation,
      onPress: () {
        showDialog(
            context: context,
            builder: (context) => const BasicUserInformation());
      },
    );
  }
}
