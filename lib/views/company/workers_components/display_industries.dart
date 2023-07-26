import 'package:flutter/material.dart';

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
          const SizedBox(height: 20),
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
