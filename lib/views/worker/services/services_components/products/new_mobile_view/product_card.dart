import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'mobile_product_details_widget.dart';
import 'show_product_details_dialog.dart';

class ProductCard extends StatelessWidget {
  final Color color;
  final String title;
  final String subtitle;
  final String amount;
  final String productId;
  final List<String> details;
  const ProductCard(
      {super.key,
        required this.color,
        required this.title,
        required this.subtitle,
        required this.amount,
        required this.productId,
        required this.details});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width * 0.95;
    return InkWell(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) => ShowProductDetailsDialog(
                membership: MobileProductDetailsWidget(
                    color: color,
                    title: title,
                    subtitle: subtitle,
                    amount: amount,
                    productId: productId,
                    details: details),
                color: color));
      },
      child: Card(
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
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Center(
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "${title.toUpperCase()} ",
                            style: GoogleFonts.montserrat(
                              fontSize: 28.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          if (subtitle != '')
                            TextSpan(
                              text:
                              "\n${subtitle.toUpperCase()}", // Added a newline for separation
                              style: GoogleFonts.montserrat(
                                fontSize: 20.0,
                                color: Colors.white,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 20.0),
                  child: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}