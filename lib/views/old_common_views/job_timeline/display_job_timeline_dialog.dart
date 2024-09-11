import 'package:blukers/services/responsive.dart';
import 'package:flutter/material.dart';

import '../../../services/make_responsive_web.dart';
import 'job_timeline.dart';

class DisplayJobTimelineDialog extends StatelessWidget {
  const DisplayJobTimelineDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        width: Responsive.isDesktop(context) ? 1500 : MediaQuery.of(context).size.width,
        height: Responsive.isDesktop(context) ? 750 : null,
        child: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            const MakeResponsiveWeb(
                image: AssetImage('assets/images/worker_job_insp_desc.png'),
                child: JobTimeline()),
            Row(
              children: [
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SizedBox(
                    height: 40,
                    width: 40,
                    child: FloatingActionButton(
                      shape: const CircleBorder(
                          side: BorderSide(color: Colors.black, width: 2)),
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.white,
                      child: const Icon(
                        Icons.close,
                        color: Colors.black,
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
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
