import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../common_files/constants.dart';
import '../../models/payment_model/paid_order.dart';

class OrderCard extends StatelessWidget {
  final PaidOrder order;
  final Color color;

  const OrderCard({Key? key, required this.order, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width * 0.95;
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      color: color,
      child: Container(
        height: height * 0.15,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      order.productName.toUpperCase(),
                      style: GoogleFonts.montserrat(
                        fontSize: 16.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(
                        height: 5.0), // Provide some spacing between the texts
                    Text(
                      order.productCategoryName.toUpperCase(),
                      style: GoogleFonts.montserrat(
                        fontSize: 12.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    // Provide some spacing between the texts
                    Text(
                      order.productSubcategoryName.toUpperCase(),
                      style: GoogleFonts.montserrat(
                        fontSize: 12.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 5.0),
                    Text(
                      formatDate(order.createdAt),
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 15.0),
                Container(
                  margin: const EdgeInsets.only(right: 20.0),
                  child: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  ),
                )
              ],
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
