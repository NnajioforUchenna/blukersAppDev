import 'package:flutter/material.dart';

import '../../../common_files/constants.dart';
import '../../../models/job_post.dart';

class DetailPageBlockThree extends StatelessWidget {
  final JobPost jobPost;

  const DetailPageBlockThree({Key? key, required this.jobPost})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text("Details",
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 15),
        Row(
          children: [
            Expanded(
              child: Text(
                "Schedule: ${jobPost.schedule}",
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: Text(
                "Job Type: ${getJobType(jobPost.jobType)}",
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        Row(
          children: [
            Expanded(
              child: Text(
                "Pay: \$${jobPost.salaryAmount.toString()} ${getSalaryType(jobPost.salaryType)}",
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
        Divider()
      ],
    );
  }
}
