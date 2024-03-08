import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../common_files/constants.dart';
import '../../../../../models/payment_model/paid_order.dart';
import '../../../../../utils/helpers/number_format.dart';
import 'status_indicator_widget.dart';

class MobileOrderDetailsWidget extends StatelessWidget {
  final Color color;
  final PaidOrder order;
  const MobileOrderDetailsWidget(
      {super.key, required this.color, required this.order});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: width * 0.18,
            height: height * 0.13,
            decoration: const BoxDecoration(
              color: Color(0xff1a75bb),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
            ),
            child: const Center(
              child: Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Icon(
                  Icons.receipt_long_outlined,
                  color: Colors.white,
                  size: 60,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Order',
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.grey[800]),
              ),
              const SizedBox(
                width: 5,
              ),
              Container(
                width: 130,
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    // a circle with # at the center
                    Container(
                      width: 25, // Adjust for desired size
                      height: 25, // Adjust for desired size
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white, // Adjust for desired color
                      ),
                      child: Center(
                        child: Text(
                          '#',
                          style: TextStyle(
                              color: Colors.grey[800],
                              fontSize:
                                  20), // Adjust for desired font size and color
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      order.orderNumber.toString(),
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Colors.grey[800]),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Divider(
            color: Colors.grey,
            thickness: 1,
            indent: width * 0.3, // Adjust for desired spacing from the start
            endIndent: width * 0.3, // Adjust for desired spacing from the end
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(20),
            ),
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            child: Text(
              order.productName,
              style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: Colors.grey[800]),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            order.productCategoryName.toUpperCase(),
            style: GoogleFonts.montserrat(
              fontSize: 12.0,
              color: Colors.grey[800],
              fontWeight: FontWeight.w500,
            ),
          ),
          // Provide some spacing between the texts
          Text(
            order.productSubcategoryName.toUpperCase(),
            style: GoogleFonts.montserrat(
              fontSize: 12.0,
              color: Colors.grey[800],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          StatusIndicatorWidget(status: order.orderStatus),
          const SizedBox(
            height: 20,
          ),
          Text(
            formatDate(order.createdAt),
            style: GoogleFonts.montserrat(
              color: Colors.grey[800],
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(20),
            ),
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
            child: Text(
              NumberFormatHelper()
                  .doubleToStrSimpleCurrency(order.orderTotalAmount / 100),
              style: GoogleFonts.montserrat(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ),
          Container(
              margin: const EdgeInsets.only(top: 40.0, bottom: 20.0),
              child: Divider(
                color: Colors.grey,
                thickness: 1,
                indent:
                    width * 0.3, // Adjust for desired spacing from the start
                endIndent:
                    width * 0.3, // Adjust for desired spacing from the end
              ))
        ],
      ),
    );
  }
}
