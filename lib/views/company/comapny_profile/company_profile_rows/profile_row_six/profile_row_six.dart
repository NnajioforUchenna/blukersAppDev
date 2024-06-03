import 'package:blukers/views/old_common_views/components/profile/profile_menu_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../../../providers/user_provider_parts/user_provider.dart';
import 'delete_profile_page.dart';

class CompanyProfileRowSix extends StatelessWidget {
  const CompanyProfileRowSix({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider up = Provider.of<UserProvider>(context);
    return ProfileMenuButton(
      text: AppLocalizations.of(context)!.deleteAccount,
      textColor: Colors.red,
      onPress: () {
        showDialog(
            context: context, builder: (context) => const DeleteAccountPage());
      },
    );
  }
}
