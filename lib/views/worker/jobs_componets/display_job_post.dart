import 'package:flutter/material.dart';

import '../../../models/job_post.dart';
// Assuming you've imported the required classes (JobPost, Skill, Address) above

class JobPostWidget extends StatelessWidget {
  final JobPost jobPost;

  JobPostWidget({required this.jobPost});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 4.0,
        margin: EdgeInsets.all(10.0),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (jobPost.companyImageUrl != null)
                Center(
                  child: Image.network(
                    jobPost.companyImageUrl!,
                    fit: BoxFit.cover,
                    width: 100.0,
                    height: 100.0,
                  ),
                ),
              SizedBox(height: 10.0),
              Text('Company ID: ${jobPost.companyId}',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 5.0),
              Text('Job Title: ${jobPost.jobTitle}'),
              SizedBox(height: 5.0),
              Text('Job Description: ${jobPost.jobDescription}'),
              SizedBox(height: 5.0),
              Text('Requirements: ${jobPost.requirements}'),
              SizedBox(height: 5.0),
              Text('Job Type: ${jobPost.jobType.toString().split('.').last}'),
              SizedBox(height: 5.0),
              ...jobPost.skills
                  .map((skill) => Text('Skill: ${skill.name}'))
                  .toList(),
              if (jobPost.addresses != null)
                ...jobPost.addresses!
                    .map((address) => Text(
                        'Address: ${address.street}, ${address.city}, ${address.state}, ${address.country}'))
                    .toList(),
              SizedBox(height: 5.0),
              Text(
                  'Number of Positions: ${jobPost.numberOfPositionsAvailable}'),
              SizedBox(height: 5.0),
              if (jobPost.jobUrgencyLevel != null)
                Text(
                    'Urgency Level: ${jobPost.jobUrgencyLevel!.toString().split('.').last}'),
              SizedBox(height: 5.0),
              if (jobPost.jobPostStatus != null)
                Text(
                    'Job Status: ${jobPost.jobPostStatus!.toString().split('.').last}'),
              SizedBox(height: 5.0),
            ],
          ),
        ),
      ),
    );
  }
}
