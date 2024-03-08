import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderAmountDisplayWidget extends StatelessWidget {
  final String amount;
  final Color color;
  const OrderAmountDisplayWidget(
      {super.key, required this.amount, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          amount.toString(),
          style: GoogleFonts.montserrat(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}
