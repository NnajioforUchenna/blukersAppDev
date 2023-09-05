import 'package:blukers/models/job_post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(0.sp),
            child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth:
                      width * 0.9, // Constrain the width to 80% of the screen
                  maxHeight:
                      height * 0.9, // Constrain the height to 70% of the screen
                ),
                child: const AnimateJobPostDetails()),
          ),
          Row(
            children: [
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(0),
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
