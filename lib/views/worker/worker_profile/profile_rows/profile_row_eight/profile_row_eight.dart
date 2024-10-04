import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../old_common_views/components/profile/profile_menu_button.dart';
import '../../../services/services_components/orders/orders_list.dart';
// import '../../../services/services_components/orders/show_order_dialog.dart';

class ProfileRowEight extends StatelessWidget {
  const ProfileRowEight({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfileMenuButton(
      text: AppLocalizations.of(context)!.orders,
      onPress: () {
        showDialog(
            context: context,
            builder: (context) => const UpdateUserInfoDialog(
                  child: OrdersList(),
                ));
      },
    );
  }
}
