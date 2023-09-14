import 'package:flutter/material.dart';

import '../../../services/make_responsive_web.dart';
import 'job_timeline.dart';

class DisplayJobTimelineDialog extends StatelessWidget {
  const DisplayJobTimelineDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          const MakeResponsiveWeb(
              image: AssetImage('assets/images/journey2DreamJob.png'),
              child: JobTimeline()),
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
