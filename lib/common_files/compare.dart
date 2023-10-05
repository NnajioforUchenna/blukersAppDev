import 'package:blukers/utils/helpers/index.dart';
import 'package:blukers/utils/styles/index.dart';
import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

class OrderCard extends StatelessWidget {
  final String orderId;
  final int createdAt;
  final String orderStatus;
  final String productName;
  final String productCategoryName;
  final String productSubcategoryName;
  final String paymentPlatformName;
  final String orderNumber;
  final double orderTotalAmount;

  const OrderCard({
    Key? key,
    required this.orderId,
    required this.createdAt,
    required this.orderStatus,
    required this.productName,
    required this.productCategoryName,
    required this.productSubcategoryName,
    required this.paymentPlatformName,
    required this.orderNumber,
    required this.orderTotalAmount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    IconData iconData;
    Color iconColor;

    // Check the value of orderStatus and set the icon accordingly
    if (orderStatus.toLowerCase() == 'completed') {
      iconData = UniconsLine.check_circle;
      iconColor = Colors.green;
    } else if (orderStatus.toLowerCase() == 'processing') {
      iconData = Icons.hourglass_top_outlined;
      // iconData = UniconsLine.process;
      // iconData = UniconsLine.hourglass;
      iconColor = Colors.blue.shade400;
    } else if (orderStatus.toLowerCase() == 'pending') {
      iconData = Icons.access_time;
      iconColor = Colors.amber;
    } else if (orderStatus.toLowerCase() == 'canceled') {
      iconData = UniconsLine.times_circle;
      iconColor = Colors.red;
    } else {
      // iconData = UniconsLine.receipt_alt;
      iconData = UniconsLine.circle;
      iconColor = Colors.grey;
    }

    // *** USE THIS TO NAVIGATE TO ANOTHER SCREEN WHEN CLICKING ON CARD
    // return InkWell(
    //   onTap: () {
    //     // context.go( route);
    //   },
    //   child: buildCard(context, iconData, iconColor),
    // );

    // *** USE THIS TO OPEN ALERTDIALOG WHEN CLICKING ON CARD
    return GestureDetector(
      onTap: () {
        // Show the modal dialog when the card is tapped
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text(''),
              content: SingleChildScrollView(
                // Wrap content with SingleChildScrollView
                child: Column(
                  // Customize the content of your modal here
                  children: [
                    const Icon(
                      UniconsLine.receipt_alt,
                      color: ThemeColors.grey1ThemeColor,
                      size: 50,
                    ),
                    Text(
                      'Order #: $orderNumber',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: ThemeColors.grey1ThemeColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Text(
                      '$productName',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: ThemeColors.black3ThemeColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '$productCategoryName',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: ThemeColors.grey1ThemeColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '$productSubcategoryName',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: ThemeColors.grey2ThemeColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Text(
                      'ORDER STATUS',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: iconColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Icon(iconData, color: iconColor, size: 60),
                    const SizedBox(height: 10),
                    Text(
                      orderStatus.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: iconColor,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      // color: Color.fromARGB(255, 243, 243, 243),
                      child: Row(
                        children: [
                          // First Container
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.only(top: 10.0),
                              // color: Colors.orange,
                              child: Align(
                                alignment: Alignment
                                    .centerLeft, // Align content to the left
                                child: Text(
                                  DateFormatHelper().intToStrDDMMYY(createdAt),
                                  style: const TextStyle(
                                    color: ThemeColors.grey2ThemeColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // Second Container
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.only(top: 10.0),
                              // color: Colors.purple,
                              child: Align(
                                alignment: Alignment
                                    .centerRight, // Align content to the right
                                child: Text(
                                  // '\$' + orderTotalAmount.toString(),
                                  NumberFormatHelper()
                                      .doubleToStrSimpleCurrency(
                                          orderTotalAmount / 100),
                                  style: const TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: const Text(
                    'OK',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
      child: buildCard(context, iconData, iconColor),
    );
  }

  Widget buildCard(
    BuildContext context,
    IconData iconData,
    Color iconColor,
  ) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            // First Row with 3 Columns
            Row(
              children: [
                // First Column (width based on content)
                Expanded(
                  flex:
                      0, // Flex 0 makes it take the minimum width required by its content
                  child: Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      // mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          // UniconsLine.check_circle,
                          iconData,
                          color: iconColor,
                          size: 50,
                        ),
                      ],
                    ),
                  ),
                ),

                // Second Column (expands to fill available space)
                Expanded(
                  flex: 1, // Flex 1 makes it expand to fill available space
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          productName,
                          style: const TextStyle(
                            color: ThemeColors.black3ThemeColor,
                            fontWeight: FontWeight.w900,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          productCategoryName.toUpperCase(),
                          style: const TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          productSubcategoryName,
                          style: const TextStyle(
                            color: Colors.black45,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Third Column (width based on content)
                const Expanded(
                  flex:
                      0, // Flex 0 makes it take the minimum width required by its content
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: ThemeColors.grey1ThemeColor,
                  ),
                ),
              ],
            ),

            // Second Row with 2 Columns
            Container(
              // color: Color.fromARGB(255, 243, 243, 243),
              child: Row(
                children: [
                  // First Container
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(top: 10.0),
                      // color: Colors.orange,
                      child: Align(
                        alignment:
                            Alignment.centerLeft, // Align content to the left
                        child: Text(
                          DateFormatHelper().intToStrDDMMYY(createdAt),
                          style: const TextStyle(
                            color: ThemeColors.grey2ThemeColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Second Container
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(top: 10.0),
                      // color: Colors.purple,
                      child: Align(
                        alignment:
                            Alignment.centerRight, // Align content to the right
                        child: Text(
                          // '\$' + orderTotalAmount.toString(),
                          NumberFormatHelper().doubleToStrSimpleCurrency(
                              orderTotalAmount / 100),
                          style: const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
