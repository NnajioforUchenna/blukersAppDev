import 'package:flutter/material.dart';

import '../../../models/worker.dart';
import 'animate_worker_details_page.dart';

class DisplayWorkerDialog extends StatelessWidget {
  final Worker worker;
  const DisplayWorkerDialog({super.key, required this.worker});

  @override
  Widget build(BuildContext context) {
    // Determine screen size for responsive design
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Dialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(32.0)),
      ),
      child: SingleChildScrollView(
        // Wrap with SingleChildScrollView to avoid overflow
        child: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.all(16.0), // Add padding around the column
              child: Column(
                children: [
                  const SizedBox(
                    height: 70,
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: width *
                          0.8, // Constrain the width to 80% of the screen
                      maxHeight: height *
                          0.7, // Constrain the height to 70% of the screen
                    ),
                    child: const AnimateWorkerDetails(),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FloatingActionButton(
                    child: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
