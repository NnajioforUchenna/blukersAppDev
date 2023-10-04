import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common_files/constants.dart';
import 'product_card.dart';

class NewMobileProductsWidget extends StatelessWidget {
  const NewMobileProductsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: height * 0.05, bottom: height * 0.1),
          child: Text(
            'Products',
            style: GoogleFonts.montserrat(
                fontWeight: FontWeight.bold, fontSize: 24),
          ),
        ),
        Column(
          children: [
            for (var product in listProducts)
              ProductCard(
                color: product['color'],
                title: product['title'],
                subtitle: product['subtitle'],
                amount: product['amount'],
                productId: product['productId'],
                details: product['details'],
              )
          ],
        )
      ],
    );
  }
}
