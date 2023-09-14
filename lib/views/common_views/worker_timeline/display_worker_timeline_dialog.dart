import 'package:flutter/material.dart';

import '../../../services/make_responsive_web.dart';
import 'worker_timeline.dart';

class DisplayWorkerTimelineDialog extends StatelessWidget {
  const DisplayWorkerTimelineDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          MakeResponsiveWeb(
              image: const AssetImage('assets/images/journey2DreamJob.png'),
              child: WorkerTimeline()),
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
