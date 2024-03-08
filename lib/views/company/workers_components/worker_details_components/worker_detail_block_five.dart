import 'package:flutter/material.dart';

import '../../../../services/responsive.dart';

class WorkerDetailBlockFive extends StatelessWidget {
  final List<String> skills;

  const WorkerDetailBlockFive({super.key, required this.skills});

  @override
  Widget build(BuildContext context) {
    double scaleFactor = Responsive.textScaleFactor(
        context); // Scale factor based on the screen size

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Skills",
            style: TextStyle(
                fontSize: 20 * scaleFactor,
                fontWeight: FontWeight.bold), // Apply scaling to font size
          ),
          const SizedBox(height: 15),
          Wrap(
            spacing: 8,
            runSpacing: 4,
            children: skills
                .map((skill) => Chip(
                      label: Text(skill,
                          style: TextStyle(
                              fontSize: 16 * scaleFactor,
                              color:
                                  Colors.white)), // Apply scaling to font size
                      backgroundColor: Colors.blue,
                    ))
                .toList(),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
