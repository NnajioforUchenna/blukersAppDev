import 'package:flutter/material.dart';

import '../../../../models/worker.dart';
import '../../../../services/responsive.dart';

class WorkerDetailBlockThree extends StatelessWidget {
  final Worker worker;

  const WorkerDetailBlockThree({
    Key? key,
    required this.worker,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double scaleFactor = Responsive.textScaleFactor(context);

    return Padding(
      padding: const EdgeInsets.all(16.0), // Add padding around the column
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Align content to start
        children: [
          Row(
            children: [
              Text("Short Description",
                  style: TextStyle(
                      fontSize: 20 * scaleFactor, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 15),
          Text(
            "Description: ${worker.workerBriefDescription}",
            style: TextStyle(fontSize: 18 * scaleFactor),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
