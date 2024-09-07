import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../../../services/responsive.dart';

class AmountDisplayWidget extends StatelessWidget {
  final String amount;
  final Color color;
  const AmountDisplayWidget(
      {super.key, required this.amount, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          '\$${amount.toString()}',
          style: GoogleFonts.montserrat(
            fontSize: Responsive.isMobile(context) ? 20.sp : 20,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        if (amount != '0')
          Text(
            'monthly',
            textAlign: TextAlign.end,
            style: GoogleFonts.montserrat(
              fontSize: Responsive.isMobile(context) ? 7.sp : 7,
              color: color,
            ),
          ),
      ],
    );
  }
}
