import 'package:blukers/models/payment_model/paid_order.dart';
import 'package:blukers/providers/app_versions_provider.dart';
import 'package:blukers/providers/user_provider.dart';
import 'package:blukers/views/common_views/components/icon_text_404.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';

import 'order_card.dart';

class OrdersList extends StatelessWidget {
  const OrdersList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppVersionsProvider avp = Provider.of<AppVersionsProvider>(context);
    UserProvider up = Provider.of<UserProvider>(context);
    double height = MediaQuery.of(context).size.height;

    if (!kIsWeb) {
      avp.checkForUpdate(context);
    }

    List<PaidOrder>? ordersList = up.appUser?.listActiveOrders.values.toList();

    return ordersList != null && ordersList.isNotEmpty
        ? SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin:
                      EdgeInsets.only(top: height * 0.05, bottom: height * 0.1),
                  child: Text(
                    'Orders',
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                ),
                Column(
                  children: List.generate(ordersList.length, (index) {
                    var order = ordersList[index];
                    return OrderCard(
                      order: order,
                      color: index % 2 == 0
                          ? Color(0xff1a75bb)
                          : Color(
                              0xffF16523), // You can also use 'index' if needed
                    );
                  }),
                ),
              ],
            ),
          )
        : Center(
            child: IconText404(
              icon: UniconsLine.receipt_alt,
              text: AppLocalizations.of(context)!.youDoNotHaveAnyOrder,
            ),
          );
  }
}
