import 'package:blukers/models/payment_model/paid_order.dart';
import 'package:blukers/providers/app_versions_provider.dart';
import 'package:blukers/providers/user_provider.dart';
import 'package:blukers/views/common_views/components/icon_text_404.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';

import '../common_views/page_template/page_template.dart';
import 'order_card.dart';

class OrdersList extends StatelessWidget {
  const OrdersList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppVersionsProvider avp = Provider.of<AppVersionsProvider>(context);
    UserProvider up = Provider.of<UserProvider>(context);

    if (!kIsWeb) {
      avp.checkForUpdate(context);
    }

    // dynamic ordersList = null;
    // dynamic ordersList = [];
    // dynamic ordersList = listOrdersSampleData;
    List<PaidOrder>? ordersList = up.appUser?.listActiveOrders.values.toList();

    return ordersList != null && ordersList.isEmpty == false
        ? PageTemplate(
            showAppBar: true,
            appBarTitle: AppLocalizations.of(context)!.orders,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Column(
                      children: [
                        for (var order in ordersList)
                          OrderCard(
                            orderId: order.id,
                            createdAt: order.createdAt,
                            orderStatus: order.orderStatus,
                            productName: order.productName,
                            productCategoryName: order.productCategoryName,
                            productSubcategoryName:
                                order.productSubcategoryName,
                            paymentPlatformName: order.paymentPlatformName,
                            orderNumber: order.orderNumber,
                            orderTotalAmount: order.orderTotalAmount,
                          )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        : PageTemplate(
            showAppBar: true,
            appBarTitle: AppLocalizations.of(context)!.orders,
            child: Center(
              child: IconText404(
                icon: UniconsLine.receipt_alt,
                text: AppLocalizations.of(context)!.youDoNotHaveAnyOrder,
              ),
            ),
          );
  }
}

// // Uncomment to test case where we have no orders, empty data.
final List<Map<String, dynamic>> listOrdersSampleDataEmpty = [];

final List<Map<String, dynamic>> listOrdersSampleData = [
  {
    'id': '1',
    'createdAt': 1692202834058,
    'orderStatus': 'processing', // pending, canceled, completed, processing,
    'productName': 'FOIA',
    'productCategoryName': 'Services',
    'productSubcategoryName': 'Immigration',
    'paymentPlatformName': 'stripe',
    'orderNumber': 'AB9102',
    'orderTotalAmount': 9203.50,
  },
  {
    'id': '2',
    'createdAt': 1692202834058,
    'orderStatus': 'completed', // pending, canceled, completed, processing,
    'productName': 'Employment Verification',
    'productCategoryName': 'Services',
    'productSubcategoryName': 'Jobs',
    'paymentPlatformName': 'apple',
    'orderNumber': 'ZK9302',
    'orderTotalAmount': 7203.21,
  },
  {
    'id': '3',
    'createdAt': 1692202834058,
    'orderStatus': 'pending', // pending, canceled, completed, processing,
    'productName': 'WS145 Welders',
    'productCategoryName': 'Certifications',
    'productSubcategoryName': 'Welding',
    'paymentPlatformName': 'android',
    'orderNumber': 'IE02KS',
    'orderTotalAmount': 5203.34,
  },
  {
    'id': '4',
    'createdAt': 1692202834058,
    'orderStatus': 'canceled', // pending, canceled, completed, processing,
    'productName': 'Strucutral Welding Principles',
    'productCategoryName': 'Courses',
    'productSubcategoryName': 'Welders',
    'paymentPlatformName': 'stripe',
    'orderNumber': 'IE02KS',
    'orderTotalAmount': 4203.98,
  },
];