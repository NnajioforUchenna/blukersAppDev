import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../common_files/constants.dart';
import 'product_card.dart';

class NewMobileProductsWidget extends StatelessWidget {
  const NewMobileProductsWidget({super.key});

  @override
  Widget build(BuildContext context) {
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
          child: AutoSizeText(
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
                title: getTitle(product['title']),
                subtitle: getTitle(product['subtitle']),
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
