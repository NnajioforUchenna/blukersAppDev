import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../common_files/constants.dart';
import 'product_card.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NewMobileProductsWidget extends StatelessWidget {
  // final ProductProvider productProvider;
  // const NewMobileProductsWidget({super.key, required this.productProvider});
  const NewMobileProductsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // List<ProductModel> listProducts = productProvider.products;

    String getTitle(title) {
      if (title.toString().toLowerCase() == "employment") {
        return AppLocalizations.of(context)!.employmentVerification1;
      }
      if (title.toString().toLowerCase() == "verification") {
        return AppLocalizations.of(context)!.employmentVerification2;
      }
      return title;
    }

    double height = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: height * 0.05, bottom: height * 0.1),
          child: Text(
            AppLocalizations.of(context)!.products,
            style: GoogleFonts.montserrat(
                fontWeight: FontWeight.bold, fontSize: 24),
          ),
        ),
        Column(
          children: [
            for (var product in listProducts)
              ProductCard(
                color: product['color'],
                // title: product['title'],
                title: getTitle(product['title']),
                // subtitle: product['subtitle'],
                subtitle: getTitle(product['subtitle']),
                amount: product['amount'],
                productId: product['productId'],
                details: product['details'],
              )
            // ProductCard(
            //   color: Colors.blue.shade700,
            //   title: product.name,
            //   subtitle: '',
            //   amount: product.regularPrice.toString(),
            //   productId: product.id,
            //   details: [''],
            // )
          ],
        )
      ],
    );
  }
}
