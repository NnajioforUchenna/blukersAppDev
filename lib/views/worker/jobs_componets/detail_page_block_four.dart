import 'package:flutter/material.dart';

import '../../../models/job_post.dart';

class DetailPageBlockFour extends StatelessWidget {
  final JobPost jobPost;

  const DetailPageBlockFour({Key? key, required this.jobPost})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Row(
            children: [
              Text("Description",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: Text(
                  jobPost.jobDescription ?? '',
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
          const Divider(),
        ],
      ),
    );
  }
}
