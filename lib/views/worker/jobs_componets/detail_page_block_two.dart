import 'package:flutter/material.dart';

import '../../../models/job_post.dart';

class DetailPageBlockTwo extends StatelessWidget {
  final JobPost jobPost;

  const DetailPageBlockTwo({Key? key, required this.jobPost}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0), // Add padding around the column
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Align content to start
        children: [
          const Row(
            children: [
              Text("About Job",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 15),
          Text(
            "Industry: ${jobPost.industryIds.join(', ')}",
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 20),
          Text(
            "Job Position: ${jobPost.jobIds.join(', ')}",
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 15),
          Text(
            "Skills: ${jobPost.skills.map((skill) => skill.name ?? '').join(', ')}",
            style: const TextStyle(fontSize: 18),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
