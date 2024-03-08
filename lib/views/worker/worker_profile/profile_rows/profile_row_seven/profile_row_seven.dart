import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../../../providers/user_provider_parts/user_provider.dart';
import '../../../services/services_components/subscription/subscription_components/mobile_view/subscription_mobile_view_widget.dart';
import '../../../services/services_components/show_service_dialog.dart';
import '../../profile_menu_button.dart';

class ProfileRowSeven extends StatelessWidget {
  const ProfileRowSeven({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider up = Provider.of<UserProvider>(context);
    return ProfileMenuButton(
      text: AppLocalizations.of(context)!.subscriptions,
      onPress: () {
        showDialog(
            context: context,
            builder: (context) => const ShowServiceDialog(
                  service: MobileSubscriptionWidget(),
                ));
      },
    );
  }
}
