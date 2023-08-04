import 'package:bulkers/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/job_post.dart';
import '../../../providers/job_posts_provider.dart';
import '../../auth/common_widget/login_or_register.dart';
import '../../common_views/loading_page.dart';
// Assuming you've imported the required classes (JobPost, Skill, Address) above

class JobPostWidget extends StatelessWidget {
  const JobPostWidget({super.key});

  @override
  Widget build(BuildContext context) {
    JobPostsProvider jp = Provider.of<JobPostsProvider>(context);
    UserProvider up = Provider.of<UserProvider>(context);
    JobPost? jobPost = jp.selectedJobPost;
    return jobPost == null
        ? Center(child: SizedBox(height: 100, width: 100, child: LoadingPage()))
        : up.appUser == null
            ? const LoginOrRegister()
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (jobPost.companyLogo != null)
                        Center(
                          child: Image.network(
                            jobPost.companyLogo!,
                            fit: BoxFit.cover,
                            width: 100.0,
                            height: 100.0,
                          ),
                        ),
                      const SizedBox(height: 10.0),
                      Text('Company ID: ${jobPost.companyId}',
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 5.0),
                      Text('Job Title: ${jobPost.jobTitle}'),
                      const SizedBox(height: 5.0),
                      Text('Job Description: ${jobPost.jobDescription}'),
                      const SizedBox(height: 5.0),
                      Text('Requirements: ${jobPost.requirements}'),
                      const SizedBox(height: 5.0),
                      Text(
                          'Job Type: ${jobPost.jobType.toString().split('.').last}'),
                      const SizedBox(height: 5.0),
                      ...jobPost.skills
                          .map((skill) => Text('Skill: ${skill.name}'))
                          .toList(),
                      if (jobPost.addresses != null)
                        ...jobPost.addresses!
                            .map((address) => Text(
                                'Address: ${address.street}, ${address.city}, ${address.state}, ${address.country}'))
                            .toList(),
                      const SizedBox(height: 5.0),
                      Text(
                          'Number of Positions: ${jobPost.numberOfPositionsAvailable}'),
                      const SizedBox(height: 5.0),
                      if (jobPost.jobUrgencyLevel != null)
                        Text(
                            'Urgency Level: ${jobPost.jobUrgencyLevel!.toString().split('.').last}'),
                      const SizedBox(height: 5.0),
                      if (jobPost.jobPostStatus != null)
                        Text(
                            'Job Status: ${jobPost.jobPostStatus!.toString().split('.').last}'),
                      const SizedBox(height: 5.0),
                    ],
                  ),
                ),
              );
  }
}
