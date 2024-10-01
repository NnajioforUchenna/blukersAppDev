import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../../../providers/user_provider_parts/user_provider.dart';
import '../../../../old_common_views/components/profile/profile_menu_button.dart';
import 'delete_profile_page.dart';

class ProfileRowNine extends StatelessWidget {
  const ProfileRowNine({super.key});

  @override
  Widget build(BuildContext context) {
   Provider.of<UserProvider>(context);
    return ProfileMenuButton(
        text: AppLocalizations.of(context)!.deleteAccount,
    textColor: const Color(0xFFC85E5E),
    trailing: SvgPicture.asset(
      "assets/icons/delete_icon.svg",
      height: 25,
      colorFilter: const ColorFilter.mode(Color(0xFFC85E5E), BlendMode.srcIn),
    ),
      onPress: () {
        showDialog(
            context: context, builder: (context) => const UpdateUserInfoDialog(child: DeleteAccountPage()));
      },
    );
  }
}
