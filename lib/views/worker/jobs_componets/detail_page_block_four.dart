import 'package:flutter/material.dart';

import '../../../models/job_post.dart';

class DetailPageBlockFour extends StatelessWidget {
  final JobPost jobPost;

  const DetailPageBlockFour({Key? key, required this.jobPost})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0), // Add padding around the edges
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Align content to start
          children: [
            const Text("Description",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 15),
            Text(
              jobPost.jobDescription ?? '',
              style: const TextStyle(fontSize: 18),
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
