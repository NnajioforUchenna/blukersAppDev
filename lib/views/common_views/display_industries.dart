import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'list_industries.dart';

class DisplayIndustries extends StatelessWidget {
  const DisplayIndustries({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text("Please select the Industry?",
                textAlign: TextAlign.center,
                style: GoogleFonts.ebGaramond(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.pink,
                )),
          ),
          const SizedBox(height: 10),
          SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              child: const ListIndustries()),
          const SizedBox(
            height: 100,
          )
        ],
      ),
    );
  }
}
