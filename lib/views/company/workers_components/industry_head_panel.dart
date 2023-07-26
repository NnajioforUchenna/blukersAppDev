import 'package:flutter/material.dart';

import '../../../models/industry.dart';

class IndustryHeadPanel extends StatelessWidget {
  final Industry industry;
  const IndustryHeadPanel({super.key, required this.industry});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          industry.name,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
