import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../old_common_views/components/profile/profile_menu_button.dart';
import 'update_industry.dart';

class ProfileRowFive extends StatelessWidget {
  const ProfileRowFive({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfileMenuButton(
      text: AppLocalizations.of(context)!.industriesSlashJobs,
      onPress: () {
        showDialog(
            context: context, builder: (context) => const UpdateUserInfoDialog(child: UpdateIndustry()));
      },
    );
  }
}
