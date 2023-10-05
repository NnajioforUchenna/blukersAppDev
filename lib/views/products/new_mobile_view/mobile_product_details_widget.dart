import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../providers/payments_provider.dart';

class MobileProductDetailsWidget extends StatelessWidget {
  final Color color;
  final String title;
  final String subtitle;
  final String amount;
  final String productId;
  final List<String> details;
  const MobileProductDetailsWidget(
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
    double width = MediaQuery.of(context).size.width;
    PaymentsProvider pp = Provider.of<PaymentsProvider>(context);
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: double.infinity,
              height: height * 0.30,
              margin: EdgeInsets.only(
                  top: height * 0.08,
                  left: 20.0,
                  right: 20.0,
                  bottom: height * 0.03),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.white,
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title.toUpperCase(),
                      style: GoogleFonts.montserrat(
                          color: Colors.grey[800],
                          fontSize: 42.0,
                          fontWeight: FontWeight.w800),
                    ),
                    if (subtitle.isNotEmpty)
                      Text(
                        subtitle.toUpperCase(),
                        style: GoogleFonts.montserrat(
                          color: Colors.grey[800],
                          fontSize: 30.0,
                        ),
                      ),
                    Text(
                      "\$$amount",
                      style: GoogleFonts.montserrat(
                          color: color,
                          fontSize: 70.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: List<Widget>.generate(
                  details.length,
                  (index) => Text(
                    details[index],
                    textAlign: TextAlign.center,
                    style: index % 2 == 0
                        ? GoogleFonts.montserrat(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ) // Style for even indexes
                        : GoogleFonts.montserrat(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                  ),
                ),
              ),
            ),
            Container(
              height: height * 0.03,
              width: width * 0.23,
              margin: EdgeInsets.only(top: height * 0.03, bottom: 30.0),
              child: ElevatedButton(
                onPressed: () {
                  pp.pay4Services(context, productId);
                },
                style: ElevatedButton.styleFrom(
                  elevation: 5,
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    side: BorderSide(
                      color: Colors.white,
                      width: 5.0, // Adjust for desired thickness
                    ),
                  ),
                ),
                child: Text(
                  'Buy',
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: height * 0.1)
          ],
        ),
      ),
    );
  }
}
