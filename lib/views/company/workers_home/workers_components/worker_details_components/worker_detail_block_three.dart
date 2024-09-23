import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../models/worker.dart';
import '../../../../../services/responsive.dart';

class WorkerDetailBlockThree extends StatelessWidget {
  final Worker worker;

  const WorkerDetailBlockThree({
    super.key,
    required this.worker,
  });

  @override
  Widget build(BuildContext context) {

    return Padding(
          padding:  EdgeInsets.only(top: Responsive.isMobile(context) ? 16 : 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, 
        children: [
           Text("Bio", 
                  style: GoogleFonts.montserrat(
                      fontSize: Responsive.isMobile(context)? 14: 20, fontWeight: FontWeight.w600)),
          SizedBox(height: Responsive.isMobile(context)? 8: 15),
          Text(
            worker.workerBriefDescription,
            style: GoogleFonts.montserrat(fontSize: Responsive.isMobile(context)? 12: 16, fontWeight: FontWeight.w500),
          ),
           SizedBox(height: Responsive.isMobile(context)? 16: 30),
         const Divider(
           color: Color.fromRGBO(0, 0, 0, 0.2),
         ),
        ],
      ),
    );
  }
}
