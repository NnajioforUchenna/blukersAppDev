import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../../../providers/user_provider_parts/user_provider.dart';
import '../../../../old_common_views/components/profile/profile_menu_button.dart';
import 'subscription_widgets.dart';

class ProfileRowSeven extends StatelessWidget {
  const ProfileRowSeven({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<UserProvider>(context);
    return ProfileMenuButton(
      text: AppLocalizations.of(context)!.subscriptions,
      onPress: () {
        // showDialog(
        //     context: context,
        //     builder: (context) => const ShowServiceDialog(
        //           service: MobileSubscriptionWidget(),
        //         ));
        showDialog(
            context: context,
            builder: (context) =>
                const UpdateUserInfoDialog(child: SubscriptionWidgetMobile()));
      },
    );
  }
}
