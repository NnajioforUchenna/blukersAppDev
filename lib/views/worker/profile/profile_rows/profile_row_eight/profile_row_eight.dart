import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../orders/orders_list.dart';
import '../../../orders/show_order_dialog.dart';
import '../../profile_menu_button.dart';

class ProfileRowEight extends StatelessWidget {
  const ProfileRowEight({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfileMenuButton(
      text: AppLocalizations.of(context)!.orders,
      onPress: () {
        showDialog(
            context: context,
            builder: (context) => const ShowOrderDialog(
                  orders: OrdersList(),
                ));
      },
    );
  }
}
