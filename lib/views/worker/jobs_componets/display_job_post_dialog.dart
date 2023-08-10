import 'package:bulkers/models/job_post.dart';
import 'package:flutter/material.dart';

import 'animate_job_post_details.dart';

class DisplayJobPostDialog extends StatelessWidget {
  final JobPost jobPost;
  const DisplayJobPostDialog({super.key, required this.jobPost});

  @override
  Widget build(BuildContext context) {
    // Determine screen size for responsive design
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Dialog(
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: width *
                          0.8, // Constrain the width to 80% of the screen
                      maxHeight: height *
                          0.8, // Constrain the height to 70% of the screen
                    ),
                    child: const AnimateJobPostDetails()),
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
