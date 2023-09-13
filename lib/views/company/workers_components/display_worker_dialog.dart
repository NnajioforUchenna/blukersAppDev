import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(14.0.sp), // Add padding around the column
            child: Column(
              children: [
                const Spacer(),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth:
                        width * 0.8, // Constrain the width to 80% of the screen
                    maxHeight: height *
                        0.85, // Constrain the height to 70% of the screen
                  ),
                  child: const AnimateWorkerDetails(),
                ),
                const Spacer(),
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
    );
  }
}
