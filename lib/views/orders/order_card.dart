import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';
import 'package:blukers/utils/styles/index.dart';

class OrderCard extends StatelessWidget {
  final String orderId;
  final int createdAt;
  final String orderStatus;
  final String productName;
  final String productCategoryName;
  final String productSubcategoryName;
  final String paymentPlatformName;
  final String orderNumber;

  const OrderCard({
    super.key,
    required this.orderId,
    this.createdAt = 1692202834058,
    this.orderStatus = 'completed',
    this.productName = 'productName',
    this.productCategoryName = 'productCategoryName',
    this.productSubcategoryName = 'productSubcategoryName',
    this.paymentPlatformName = 'paymentPlatformName',
    this.orderNumber = 'orderNumber',
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigator.pushNamed(context, route);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: const Padding(
            padding: EdgeInsets.only(left: 16.0, top: 16.0, bottom: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // const Center(
                      //   child: Icon(
                      //     UniconsLine.user_plus,
                      //     size: 30,
                      //     color: ThemeColors.blukersOrangeThemeColor,
                      //   ),
                      // ),
                      // Center(
                      //   child: Text(
                      //     title,
                      //     style: const TextStyle(
                      //       fontSize: 20.0,
                      //       color: ThemeColors.blukersOrangeThemeColor,
                      //       fontWeight: FontWeight.bold,
                      //     ),
                      //   ),
                      // ),
                      // const SizedBox(height: 8.0),
                      // Text(
                      //   description,
                      //   style: const TextStyle(
                      //     fontSize: 16.0,
                      //     color: ThemeColors.grey1ThemeColor,
                      //   ),
                      // ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: ThemeColors.grey1ThemeColor,
                ) // Pointer icon at the trailing end
              ],
            ),
          ),
        ),
      ),
    );
  }
}
