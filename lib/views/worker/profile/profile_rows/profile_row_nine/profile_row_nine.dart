import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../../../providers/user_provider_parts/user_provider.dart';
import '../../../../common_views/components/confirmation_dialog.dart';
import '../../profile_menu_button.dart';

class ProfileRowNine extends StatelessWidget {
  const ProfileRowNine({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider up = Provider.of<UserProvider>(context);
    return ProfileMenuButton(
      text: AppLocalizations.of(context)!.deleteAccount,
      textColor: Colors.red,
      onPress: () {
        // print("Section clicked/ Edit Clicked");
        if (up.appUser != null) {
          // print("delete user");
          // chatProvider.clearGroups();
          // up.deleteUser(up.appUser!.uid);
          confirmationDialog(
            context: context,
            stringsTemplate: 'deleteAccount',
            onConfirm: () async {
              // Navigator.of(context).pushReplacementNamed('/');
              await up.deleteUser(up.appUser!.uid);
              Navigator.of(context).pushReplacementNamed('/');
            },
          );
        }
      },
    );
  }
}
