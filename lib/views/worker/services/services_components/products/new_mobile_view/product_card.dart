import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'mobile_product_details_widget.dart';
import 'show_product_details_dialog.dart';

class ProductCard extends StatelessWidget {
  final Color color;
  final String title;
  final String subtitle;
  final String amount;
  final String description;
  final String productId;
  final List<String> details;

  const ProductCard(
      {super.key,
      required this.color,
      required this.title,
      required this.subtitle,
      required this.amount,
      required this.productId,
      required this.details,
      required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      padding: const EdgeInsets.all(15),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFF5F5F5), width: 1.9),
        // Black border
        borderRadius:
            BorderRadius.circular(8.0), // Optional: Rounded corners
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Text(
              title.toUpperCase(),
              style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                  fontSize: 12.0),
            ),
            const SizedBox(height: 15),
            Text(
              '\$$amount',
              style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 20.0),
            ),
            const SizedBox(height: 10),
            Text(
              description,
              style: GoogleFonts.montserrat(fontSize: 12.0),
            ),
            const SizedBox(height: 10),
            InkWell(
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
              child: Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  // Background color
                  borderRadius: BorderRadius.circular(50.0),
                  // Rounded corners
                  border: Border.all(
                      color: Colors.blue, width: 1.5), // Blue border
                ),
                child: Center(
                  child: Text(
                    'Buy Now',
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
