import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../common_files/constants.dart';
import '../common_views/page_template/page_template.dart';
import 'offer_card.dart';

class OffersList extends StatelessWidget {
  const OffersList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                'Offers List',
                style: GoogleFonts.montserrat(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Column(
                children: [
                  for (var offer in listOffers)
                    OfferCard(
                      title: offer['title']!,
                      description: offer['description']!,
                      route: offer['route']!,
                    )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
