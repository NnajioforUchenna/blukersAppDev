// ignore_for_file: use_build_context_synchronously

import 'package:blukers/data_providers/chat_data_provider.dart';
import 'package:blukers/providers/company_chat_provider.dart';
import 'package:blukers/views/old_common_views/components/confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../../providers/user_provider_parts/user_provider.dart';
import '../../profile_menu_button.dart';

class ProfileRowTen extends StatelessWidget {
  const ProfileRowTen({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider up = Provider.of<UserProvider>(context);
    CompanyChatProvider chatProvider =
        Provider.of<CompanyChatProvider>(context);
    return ProfileMenuButton(
      text: AppLocalizations.of(context)!.logout,
      textColor: Colors.red,
      onPress: () {
        confirmationDialog(
                    context: context,
                    stringsTemplate: 'logout',
                    onConfirm: () async {
                      chatProvider.clearGroups();
                      await up.signOut();
                      context.go('/');
                    },
                  );
        // print("Section clicked/ Edit Clicked");
        // if (up.appUser != null) {
        //   // print("delete user");
        //   // chatProvider.clearGroups();
        //   // up.deleteUser(up.appUser!.uid);
        //   confirmationDialog(
        //     context: context,
        //     stringsTemplate: 'deleteAccount',
        //     onConfirm: () async {
        //       // Navigator.of(context).pushReplacementNamed('/');
        //       await up.deleteUser(up.appUser!.uid);
        //       Navigator.of(context).pushReplacementNamed('/');
        //     },
        //   );
        // }
      },
    );
  }
}
