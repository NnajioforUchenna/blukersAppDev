import 'package:bulkers/models/job_post.dart';
import 'package:flutter/material.dart';

import 'display_job_post.dart';

class DisplayJobPostDialog extends StatelessWidget {
  final JobPost jobPost;
  const DisplayJobPostDialog({super.key, required this.jobPost});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Stack(
        alignment: Alignment.topRight,
        children: <Widget>[
          Column(
            children: [
              const SizedBox(
                height: 70,
              ),
              JobPostWidget(
                jobPost: jobPost,
              )
            ],
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
